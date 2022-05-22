import Foundation

public class BuildProductionAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        
        super.init(id: 2, name: "Build Production", game: game, player: player)
        
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
        return -1
    }
    
    public override func execute() {
        city.removeAvailable(action: self)
        //print("Building production every turn")
    }
    
    public override func clone() -> Action {
        let copy = BuildProductionAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
