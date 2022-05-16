import Foundation

public class BuildColossusAction: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Build Colossus")
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 200
    }
    
    public override func execute(game: Game, player: Player) {
        if player.canBuild(wonder: WonderType.Colossus) {
            city.build(WonderType.Colossus)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildColossusAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
