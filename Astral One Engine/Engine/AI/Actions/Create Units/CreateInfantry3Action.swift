import Foundation

public class CreateInfantry3Action: Action {
    
    public override init() {
        super.init()
        
        preconditions = []
        effects = []
        cost = 30
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(unit: Infantry3(theme: game.theme,
                                   playerId: player.playerId,
                                   name: "Archer",
                                   position: Position(row: 0, col: 0)))
    }
}
