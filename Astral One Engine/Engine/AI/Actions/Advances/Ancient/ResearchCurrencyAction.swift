import Foundation

public class ResearchCurrencyAction: Action {
    
    public init() {
        super.init(id: 2, name: "Create Horseman")
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(unit: Infantry1(theme: game.theme,
                                   playerId: player.playerId,
                                   name: "Warrior",
                                   position: Position(row: 0, col: 0)))
    }
    
    public override func clone() -> Action {
        let copy = CreateCavalry1Action()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
