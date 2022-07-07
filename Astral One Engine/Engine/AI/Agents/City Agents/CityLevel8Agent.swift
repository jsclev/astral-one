import Foundation

public class CityLevel8Agent: CityAgent {
    
    public override init(player: AIPlayer, city: City) throws {
        try super.init(player: player, city: city)
    }
    
    public override func getNextCommand() -> Command {
        print("Num available commands: \(availableCommands.count)")
        let randNum = Int.random(in: 0..<availableCommands.count)
        
        return availableCommands[randNum]
        
    }
}
