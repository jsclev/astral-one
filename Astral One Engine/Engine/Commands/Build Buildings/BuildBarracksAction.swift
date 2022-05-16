import Foundation

public class BuildBarracksAction: Action {
//    private let city: City
    
    public init() {
//        self.city = city
        super.init(id: 2, name: "Build Barracks")
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 40
    }
    
    public override func execute(game: Game, player: Player) {
//        if city.canBuild(building: BuildingType.Barracks) {
//            city.removeAvailable(action: self)
//            city.build(BuildingType.Barracks)
//        }
    }
    
    public override func execute(game: Game, player: Player, city: City) {
        if city.canBuild(building: BuildingType.Barracks) {
            city.removeAvailable(action: self)
            city.build(BuildingType.Barracks)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildBarracksAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
