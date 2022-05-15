import Foundation

public class BuildBarracksAction: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Build Barracks_\(city.name)")
        
        preconditions = []
        
        effects = [
            "city_produces_veteran_ground_units"
        ]
        
        cost = 40
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        city.removeAvailable(action: self)

        city.addBarracks()
    }
    
    public override func clone() -> Action {
        let copy = BuildBarracksAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
