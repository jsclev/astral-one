import Foundation

public class BuildBarracksAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        
        super.init(id: 2, name: "Build Barracks", game: game, player: player)

        preconditions = []

        effects = [
            "city_produces_veteran_ground_units"
        ]

        cost = 40
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        if city.canBuild(building: BuildingType.Barracks) {
            city.removeAvailable(action: self)
            city.build(BuildingType.Barracks)
        }
        
    }
    
    public override func clone() -> Action {
        let copy = BuildBarracksAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
