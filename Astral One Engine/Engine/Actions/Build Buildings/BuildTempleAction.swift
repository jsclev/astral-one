import Foundation

public class BuildTempleAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Build Temple", game: game, player: player)
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 40
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        if city.canBuild(building: BuildingType.Temple) {
            city.removeAvailable(action: self)
            city.build(BuildingType.Temple)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildTempleAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
