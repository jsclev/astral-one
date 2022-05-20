import Foundation

public class BuildHarborAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Build Harbor", game: game, player: player)
        
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
        if city.canBuild(building: BuildingType.Harbor) {
            city.removeAvailable(action: self)
            city.build(BuildingType.Harbor)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildHarborAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
