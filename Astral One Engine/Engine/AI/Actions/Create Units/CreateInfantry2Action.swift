import Foundation

public class CreateInfantry2Action: Action {
    
    public override init() {
        super.init()
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(unit: Infantry2(theme: game.theme,
                                   playerId: player.playerId,
                                   name: "Phalanx",
                                   position: Position(row: 0, col: 0)))
    }
}
