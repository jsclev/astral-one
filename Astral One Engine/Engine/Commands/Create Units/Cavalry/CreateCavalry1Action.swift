import Foundation

public class CreateCavalry1Action: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Create Cavalry1", game: game, player: player)

        preconditions = []
        effects = []
        cost = 20
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        let unit = Cavalry1(game: game,
                            player: player,
                            theme: game.theme,
                            name: "Horseman",
                            position: city.position)
        
        if city.has(building: BuildingType.Barracks) {
            unit.makeVeteran()
        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateCavalry1Action(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
