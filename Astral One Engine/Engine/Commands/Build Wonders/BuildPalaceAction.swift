import Foundation

public class BuildPalaceAction: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Build Pyramids")
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 200
    }
    
    public override func execute(game: Game, player: Player) {
        if player.canBuild(buildingType: BuildingType.Palace) {
            city.build(BuildingType.Palace)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildPalaceAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
