import Foundation

public class CreateCavalry1Action: Action {
    
    public override init() {
        super.init()
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(unit: Infantry1(theme: game.theme,
                                   playerId: player.playerId,
                                   name: "Warrior",
                                   position: Position(row: 0, col: 0)))
    }
}
