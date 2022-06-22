import Foundation

public class BuildGranaryAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Build Granary", game: game, player: player)
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 60
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        if city.canBuild(building: BuildingType.Granary) {
            city.removeAvailable(action: self)
            city.build(BuildingType.Granary)
        }
        
    }
    
    public override func clone() -> Action {
        let copy = BuildGranaryAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
