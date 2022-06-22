import Foundation

public class CreateInfantry3Action: Action {
    private let city: City

    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Create Infantry3", game: game, player: player)

        preconditions = []
        effects = []
        cost = 30
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        let unit = Infantry3(game: game,
                             player: player,
                             theme: game.theme,
                             name: "Archer",
                             position: city.position)
        
        if city.has(building: BuildingType.Barracks) {
            unit.makeVeteran()
        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateInfantry3Action(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
