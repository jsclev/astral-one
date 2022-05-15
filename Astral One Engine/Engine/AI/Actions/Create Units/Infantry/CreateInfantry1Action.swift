import Foundation

public class CreateInfantry1Action: Action {
    private let city: City
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Create Warrior")
        
        preconditions = []
        effects = []
        cost = 10
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        let unit = Infantry1(game: game,
                             player: player,
                             theme: game.theme,
                             name: "Warrior",
                             position: city.position)
        
        if city.hasBarracks {
            unit.makeVeteran()
        }
        
        
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateInfantry1Action(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
