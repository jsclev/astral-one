import Foundation
import Combine

public class AIPlayerAgent {
    public let player: AIPlayer
    public let diplomacyAgent: DiplomacyAgent
    public let scienceAgent: ScienceAgent
    public var settlerAgents: [SettlerAgent] = []
    public var cityAgents: [CityAgent] = []
    private var cancellable = Set<AnyCancellable>()

    
    public init(player: AIPlayer) throws {
        self.player = player
        
        diplomacyAgent = DiplomacyAgent(player: player)
        scienceAgent = ScienceAgent(player: player)
        
        for settler in player.settlers {
            settlerAgents.append(try SettlerAgent(player: player, settler: settler))
        }
        
        for city in player.map.cities {
            cityAgents.append(try CityAgent(player: player, city: city))
        }
        

    }
    
    public func executeActions() {
        
    }
}
