import Foundation

public class CreateExplorerAction: Action {
    private let city: City
    
    public init(city: City) {
        self.city = city
        super.init(id: 2, name: "Create Explorer")
        
        preconditions = []
        effects = []
        cost = 30
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(unit: Explorer(game: game,
                                  player: player,
                                  theme: game.theme,
                                  name: "Explorer",
                                  position: city.position))
    }
    
    public override func clone() -> Action {
        let copy = CreateExplorerAction(city: city)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
