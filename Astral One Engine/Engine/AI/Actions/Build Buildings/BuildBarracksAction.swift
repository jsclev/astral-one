import Foundation

public class BuildBarracksAction: Action {
    public override init() {
        super.init()
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 40
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        if player.cities.count > 0 {
            player.cities[0].addBarracks()
        }
    }
}
