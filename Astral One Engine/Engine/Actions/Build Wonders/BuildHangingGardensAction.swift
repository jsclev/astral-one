import Foundation

public class BuildHangingGardensAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Build Hanging Gardens", game: game, player: player)
        
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
        if player.canBuild(wonder: WonderType.HangingGardens) {
            city.removeAvailable(action: self)
            city.build(WonderType.HangingGardens)
        }
    }
    
    public override func clone() -> Action {
        let copy = BuildHangingGardensAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
