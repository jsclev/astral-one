import Foundation

public class BuildWallsAction: Action {
    public override init() {
        super.init()
        
        preconditions = [
            "has_masonry_advance"
        ]
        
        effects = [
            "3x_defense_bonus_vs_ground_attack"
        ]
        
        cost = 80
    }
    
    public override func execute(game: Game, player: Player) {
//        player.add(advance: Advance())
    }
}
