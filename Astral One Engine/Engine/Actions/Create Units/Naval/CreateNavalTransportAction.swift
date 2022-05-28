import Foundation

public class CreateNavalTransportAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Create Naval Transport", game: game, player: player)
        
        preconditions = []
        effects = []
        cost = 10
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        let unit = NavalTransport(game: game,
                          player: player,
                          theme: game.theme,
                          name: "Transport",
                          position: city.position)
        unit.homeCity = city
        
        //        if city.hasPortFacility {
        //            unit.makeVeteran()
        //        }
        
        player.add(unit: unit)
    }
    
    public override func clone() -> Action {
        let copy = CreateNaval1Action(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
