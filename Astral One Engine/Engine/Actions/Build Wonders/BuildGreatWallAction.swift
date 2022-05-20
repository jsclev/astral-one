import Foundation

public class BuildGreatWallAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Build Great Wall", game: game, player: player)
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 200
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        if player.canBuild(wonder: WonderType.GreatWall) {
            city.removeAvailable(action: self)
            
            for theCity in player.cities {
                if theCity.canBuild(building: BuildingType.CityWalls) {
                    theCity.build(BuildingType.CityWalls)
                }
            }
            city.build(WonderType.GreatWall)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildGreatWallAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
