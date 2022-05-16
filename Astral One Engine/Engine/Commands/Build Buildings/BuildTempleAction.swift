import Foundation

public class BuildTempleAction: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Build Temple")
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 40
    }
    
    public override func execute(game: Game, player: Player) {
        if city.canBuild(building: BuildingType.Temple) {
            city.removeAvailable(action: self)
            city.build(BuildingType.Temple)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildTempleAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
