import Foundation

public class CreateInfantry3Action: Action {
    private let city: City

    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Create Infantry3")

        preconditions = []
        effects = []
        cost = 30
    }
    
    public override func execute(game: Game, player: Player) {
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
        let copy = CreateInfantry3Action(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
