import Foundation

public class CreateSettlerAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Create Settler", game: game, player: player)
        
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
        let unit = Settler(game: game,
                            player: player,
                            theme: game.theme,
                            name: "Settler",
                            position: city.position)
        
        if city.has(building: BuildingType.Barracks) {
            unit.makeVeteran()
        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateSettlerAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
