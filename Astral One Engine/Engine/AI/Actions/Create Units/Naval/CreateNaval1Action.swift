import Foundation

public class CreateNaval1Action: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Create Trireme")
        
        preconditions = []
        effects = []
        cost = 10
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        let unit = Naval1(game: game,
                          player: player,
                          theme: game.theme,
                          name: "Trireme",
                          position: city.position)
        
//        if city.hasBarracks {
//            unit.makeVeteran()
//        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateNaval1Action(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
