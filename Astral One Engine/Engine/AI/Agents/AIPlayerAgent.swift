import Foundation
import Combine

public class AIPlayerAgent {
    public let game: Game
    public let player: Player
    public let diplomacyAgent: DiplomacyAgent
    public let scienceAgent: ScienceAgent
    public var settlerAgents: [SettlerAgent] = []
    public var cityAgents: [CityAgent] = []
    private var cancellable = Set<AnyCancellable>()
    
    
    public init(game: Game, player: Player) throws {
        self.game = game
        self.player = player
        
        diplomacyAgent = DiplomacyAgent(player: player)
        scienceAgent = ScienceAgent(player: player)
        
        for settler in player.settlers {
            settlerAgents.append(try SettlerAgent(player: player, settler: settler))
        }
        
        for city in player.map.cities {
            cityAgents.append(try CityAgent(game: game, player: player, city: city))
        }
        
        
    }
    
    public func processPlayerTurn() throws {
//        if player.ordinal > 1 {
//            return
//        }
        print("----------------------------------------------------")
        print("Starting turn \(game.currentTurn.ordinal) for \(game.currentPlayer.name)...")
        
        let city = player.map.cities[0]
        let cityAgent = try CityAgent.getAgent(game: game,
                                               player: player,
                                               city: city)
        let cityAgentCmd = cityAgent.getNextCommand()
        errorCheck(cityAgentCmd.execute())
        
        let research = ResearchAdvanceCommand(db: game.db,
                                              player: player,
                                              turn: game.currentTurn,
                                              advanceType: AdvanceType.Pottery)
        errorCheck(research.execute())

        let settlerCmd = CreateSettlerCommand(db: game.db,
                                                  player: player,
                                                  turn: game.currentTurn,
                                                  tile: player.map.tile(at: city.position))
        errorCheck(settlerCmd.execute())

        let settlerAgent = try SettlerAgent(player: player,
                                            settler: settlerCmd.settler)
        if let positionUtility = try settlerAgent.getSettleCityPosition() {
            print("\(player.name) SettlerAgent found location \(positionUtility.position) for city.")

            let moveUnitCmd = MoveUnitCommand(db: game.db,
                                           player: player,
                                           turn: game.currentTurn,
                                           unit: settlerCmd.settler,
                                           to: positionUtility.position)
            errorCheck(moveUnitCmd.execute())
            
            let createCityCmd = CreateCityCommand(db: game.db,
                                               player: player,
                                               turn: game.currentTurn,
                                               cityCreator: settlerCmd.settler,
                                               cityName: "Auto City")
            errorCheck(createCityCmd.execute())
            print("\(player.name) settled a city at \(positionUtility.position).")
        }
        
        let turnCmd = EndPlayerTurnCommand(db: game.db,
                                           player: player,
                                           turn: game.currentTurn)
        errorCheck(turnCmd.execute())
    }
    
    private func errorCheck(_ commandResult: CommandResult) {
        if commandResult.status != CommandStatus.Ok {
            fatalError(commandResult.message)
        }
    }
}
