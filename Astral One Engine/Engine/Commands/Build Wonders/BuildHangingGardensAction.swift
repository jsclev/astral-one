import Foundation

public class BuildHangingGardensAction: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Build Hanging Gardens")
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 200
    }
    
    public override func execute(game: Game, player: Player) {
        if player.canBuild(wonder: WonderType.HangingGardens) {
            city.build(WonderType.HangingGardens)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildHangingGardensAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
