import Foundation

public class CreateExplorerAction: Action {
    
    public init() {
        super.init(id: 2, name: "Create Explorer")
        
        preconditions = []
        effects = []
        cost = 10
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(unit: Explorer(theme: game.theme,
                                  playerId: player.playerId,
                                  name: "Explorer",
                                  position: Position(row: 0, col: 0)))
    }
    
    public override func clone() -> Action {
        let copy = CreateExplorerAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
