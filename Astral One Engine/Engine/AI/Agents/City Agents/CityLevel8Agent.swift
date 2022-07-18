import Foundation

public class CityLevel8Agent: CityAgent {
    
    public override init(game: Game, player: AIPlayer, city: City) throws {
        try super.init(game: game, player: player, city: city)
    }
    
    public override func getNextCommand() -> Command {
        let randNum = Int.random(in: 0..<availableCommands.count)
        
        if player.strategy.cityQuantity > 0.5 &&
            player.map.cities.count < 3 {
            return CreateSettlerCommand(db: game.db,
                                        player: player,
                                        turn: game.currentTurn,
                                        tile: player.map.tile(at: city.position))
        }
        
        return availableCommands[randNum]
        
    }
}
