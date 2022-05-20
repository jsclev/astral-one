import Foundation

public class CreateExplorerAction: Action {
    private let city: City
    
    public init(game: Game, player: Player, city: City) {
        self.city = city
        super.init(id: 2, name: "Create Explorer", game: game, player: player)
        
        preconditions = []
        effects = []
        cost = 30
    }
    
    public override var numTurns: Double {
        return Double(cost) / Double(city.getProductionPerTurn())
    }
    
    public override func execute() {
        player.add(unit: Explorer(game: game,
                                  player: player,
                                  theme: game.theme,
                                  name: "Explorer",
                                  position: city.position))
    }
    
    public override func clone() -> Action {
        let copy = CreateExplorerAction(game: game, player: player, city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
