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
        Debug.shared.reset()
        
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
        
        let cavalry6Cmd = CreateCavalry6Command(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                city: city)
        errorCheck(cavalry6Cmd.execute())
        
        let moveCavalry6Cmd = MoveUnitCommand(db: game.db,
                                              player: player,
                                              turn: game.currentTurn,
                                              unit: cavalry6Cmd.cavalry,
                                              to: Position(row: 28,
                                                           col: 18))
        errorCheck(moveCavalry6Cmd.execute())
        
        let cavalry7Cmd = CreateCavalry7Command(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                city: city)
        errorCheck(cavalry7Cmd.execute())
        
        let moveCavalry7Cmd = MoveUnitCommand(db: game.db,
                                              player: player,
                                              turn: game.currentTurn,
                                              unit: cavalry7Cmd.cavalry,
                                              to: Position(row: 29,
                                                           col: 20))
        errorCheck(moveCavalry7Cmd.execute())
        
        let settlerAgent = try SettlerAgent(player: player,
                                            settler: settlerCmd.settler)
        if let positionUtility = try settlerAgent.getSettleCityPosition() {
            print("\(player.name) using settler at \(settlerCmd.settler.position) to build city at \(positionUtility.position).")
            let moveUnitCmd = MoveUnitCommand(db: game.db,
                                              player: player,
                                              turn: game.currentTurn,
                                              unit: settlerCmd.settler,
                                              to: positionUtility.position)
            errorCheck(moveUnitCmd.execute())
            
            let createCityCmd = CreateCityCommand(db: game.db,
                                                  player: player,
                                                  turn: game.currentTurn,
                                                  cityCreator: settlerCmd.settler)
            errorCheck(createCityCmd.execute())
            
            let cavalry8Cmd = CreateCavalry8Command(db: game.db,
                                                    player: player,
                                                    turn: game.currentTurn,
                                                    city: createCityCmd.city)
            errorCheck(cavalry8Cmd.execute())
            
            let moveCavalry8Cmd = MoveUnitCommand(db: game.db,
                                                  player: player,
                                                  turn: game.currentTurn,
                                                  unit: cavalry8Cmd.cavalry,
                                                  to: Position(row: 30,
                                                               col: 18))
            errorCheck(moveCavalry8Cmd.execute())
            
            let naval1Cmd = CreateNaval1Command(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                city: createCityCmd.city)
            errorCheck(naval1Cmd.execute())
            
            let moveNaval1Cmd = MoveUnitCommand(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                unit: naval1Cmd.naval,
                                                to: Position(row: 34,
                                                             col: 17))
            errorCheck(moveNaval1Cmd.execute())
            
            let naval2Cmd = CreateNaval2Command(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                city: createCityCmd.city)
            errorCheck(naval2Cmd.execute())
            
            let moveNaval2Cmd = MoveUnitCommand(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                unit: naval2Cmd.naval,
                                                to: Position(row: 32,
                                                             col: 20))
            errorCheck(moveNaval2Cmd.execute())
            
            let naval3Cmd = CreateNaval3Command(db: game.db,
                                                    player: player,
                                                    turn: game.currentTurn,
                                                    city: createCityCmd.city)
            errorCheck(naval3Cmd.execute())
            
            let moveNaval3Cmd = MoveUnitCommand(db: game.db,
                                                  player: player,
                                                  turn: game.currentTurn,
                                                  unit: naval3Cmd.naval,
                                                  to: Position(row: 35,
                                                               col: 19))
            errorCheck(moveNaval3Cmd.execute())
            
            let naval4Cmd = CreateNaval4Command(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                city: createCityCmd.city)
            errorCheck(naval4Cmd.execute())
            
            let moveNaval4Cmd = MoveUnitCommand(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                unit: naval4Cmd.naval,
                                                to: Position(row: 34,
                                                             col: 19))
            errorCheck(moveNaval4Cmd.execute())
            
            let naval5Cmd = CreateNaval5Command(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                city: createCityCmd.city)
            errorCheck(naval5Cmd.execute())
            
            let moveNaval5Cmd = MoveUnitCommand(db: game.db,
                                                player: player,
                                                turn: game.currentTurn,
                                                unit: naval5Cmd.naval,
                                                to: Position(row: 34,
                                                             col: 16))
            errorCheck(moveNaval5Cmd.execute())
        }
        
        let turnCmd = EndPlayerTurnCommand(db: game.db,
                                           player: player,
                                           turn: game.currentTurn)
        errorCheck(turnCmd.execute())
        
        print("Debug counter: \(Debug.shared.counter)")
    }
    
    private func errorCheck(_ commandResult: CommandResult) {
        if commandResult.status != CommandStatus.Ok {
            //fatalError(commandResult.message)
        }
    }
}
