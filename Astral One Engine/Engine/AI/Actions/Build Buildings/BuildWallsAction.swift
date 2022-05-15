import Foundation

public class BuildWallsAction: Action {
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
        city.removeAvailable(action: self)

        city.addWalls()
    }
    
    public override func clone() -> Action {
        let copy = BuildWallsAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
