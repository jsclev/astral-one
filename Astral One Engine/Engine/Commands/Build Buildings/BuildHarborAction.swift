import Foundation

public class BuildHarborAction: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Build Harbor")
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 60
    }
    
    public override func execute(game: Game, player: Player) {
        if city.canBuild(building: BuildingType.Harbor) {
            city.removeAvailable(action: self)
            city.build(BuildingType.Harbor)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildHarborAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
