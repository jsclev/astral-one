import Foundation

public class CreateCavalry1Action: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Create Horseman")

        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        let unit = Cavalry1(game: game,
                            player: player,
                            theme: game.theme,
                            name: "Horseman",
                            position: city.position)
        
        if city.hasBarracks {
            unit.makeVeteran()
        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateCavalry1Action(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
