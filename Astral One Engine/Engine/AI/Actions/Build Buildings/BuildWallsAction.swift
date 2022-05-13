import Foundation

public class BuildWallsAction: Action {
    public init() {
        super.init(id: 2, name: "Build City Walls")

        preconditions = [
            "has_masonry_advance"
        ]
        
        effects = [
            "3x_defense_bonus_vs_ground_attack"
        ]
        
        cost = 80
    }
    
    public override func execute(game: Game, player: Player) {
        if player.cities.count > 0 {
            player.cities[0].addWalls()
        }
        
        player.removeAvailable(action: BuildWallsAction())
    }
}
