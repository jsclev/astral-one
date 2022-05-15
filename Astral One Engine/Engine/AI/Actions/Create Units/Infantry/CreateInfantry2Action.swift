import Foundation

public class CreateInfantry2Action: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Create Phalanx")

        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        let unit = Infantry2(game: game,
                             player: player,
                             theme: game.theme,
                             name: "Phalanx",
                             position: city.position)
        
        if city.hasBarracks {
            unit.makeVeteran()
        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateInfantry2Action(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
