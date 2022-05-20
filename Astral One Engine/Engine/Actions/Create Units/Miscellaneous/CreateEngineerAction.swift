import Foundation

public class CreateEngineerAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Create Engineer", game: game, player: player)
        
        preconditions = []
        effects = []
        cost = 40
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        let unit = Engineer(game: game,
                            player: player,
                            theme: game.theme,
                            name: "Engineer",
                            position: city.position)
        
        if city.has(building: BuildingType.Barracks) {
            unit.makeVeteran()
        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateEngineerAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
