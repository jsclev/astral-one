import Foundation

public class CreateNaval1Action: Action {
    
    public init() {
        super.init(id: 2, name: "Create Trireme")
        
        preconditions = []
        effects = []
        cost = 10
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(unit: Naval1(theme: game.theme,
                                playerId: player.playerId,
                                name: "Trireme",
                                position: Position(row: 0, col: 0)))
    }
    
    public override func clone() -> Action {
        let copy = CreateNaval1Action()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
