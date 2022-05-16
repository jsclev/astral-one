import Foundation

public class CreateInfantry4Action: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Create Infantry4")
        
        preconditions = []
        effects = []
        cost = 20
    }
    
    public override func execute(game: Game, player: Player) {
        let unit = Infantry4(game: game,
                             player: player,
                             theme: game.theme,
                             name: "Pikeman",
                             position: city.position)
        
        if city.has(building: BuildingType.Barracks) {
            unit.makeVeteran()
        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateInfantry4Action(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
