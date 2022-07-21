import Foundation

public class CityLevel1Agent: CityAgent {
    
    public override init(game: Game, player: Player, city: City) throws {
        try super.init(game: game, player: player, city: city)
    }
    
    public override func getNextCommand() -> Command {
        let randNum = Int.random(in: 0..<availableCommands.count)
        
        return availableCommands[randNum]
    }
}
