import Foundation

public class CityLevel1Agent: CityAgent {
    
    public override init(player: AIPlayer, city: City) throws {
        try super.init(player: player, city: city)
    }
    
    public override func getNextCommand() -> Command {
        let randNum = Int.random(in: 0..<availableCommands.count)
        
        return availableCommands[randNum]
    }
}
