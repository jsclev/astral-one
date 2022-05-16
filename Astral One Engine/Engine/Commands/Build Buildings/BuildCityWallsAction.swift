import Foundation

public class BuildCityWallsAction: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
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
        if city.canBuild(building: BuildingType.CityWalls) {
            city.removeAvailable(action: self)
            city.build(BuildingType.CityWalls)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildCityWallsAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
