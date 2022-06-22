import Foundation

public class BuildCityWallsAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Build City Walls", game: game, player: player)

        preconditions = [
            "has_masonry_advance"
        ]
        
        effects = [
            "3x_defense_bonus_vs_ground_attack"
        ]
        
        cost = 80
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        if city.canBuild(building: BuildingType.CityWalls) {
            city.removeAvailable(action: self)
            city.build(BuildingType.CityWalls)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildCityWallsAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
