import Foundation

public class BuildBarracksAction: Action {
    public init() {
        super.init(id: 2, name: "Build Barracks")

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
        
        player.removeAvailable(action: BuildBarracksAction())
    }
}
