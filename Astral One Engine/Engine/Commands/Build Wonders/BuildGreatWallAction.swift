import Foundation

public class BuildGreatWallAction: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Build Great Wall")
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 200
    }
    
    public override func execute(game: Game, player: Player) {
        if player.canBuild(wonder: WonderType.GreatWall) {
            city.build(WonderType.GreatWall)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildGreatWallAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
