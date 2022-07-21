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
    
    public func getNextCommands() throws -> [Command] {
        var cmds: [Command] = []
        
        let city = player.map.cities[0]
        let cityAgent = try CityAgent.getAgent(game: game,
                                               player: player,
                                               city: city)
        let cityAgentCmd = cityAgent.getNextCommand()
        cmds.append(cityAgentCmd)
        
        let research = ResearchAdvanceCommand(db: game.db,
                                              player: player,
                                              turn: game.currentTurn,
                                              advanceType: AdvanceType.Pottery)
        cmds.append(research)
        
        let turnCmd = EndPlayerTurnCommand(db: game.db,
                                           player: player,
                                           turn: game.currentTurn)
        cmds.append(turnCmd)
        
        return cmds
    }
}
