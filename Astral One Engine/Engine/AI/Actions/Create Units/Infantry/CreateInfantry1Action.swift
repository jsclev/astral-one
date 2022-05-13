import Foundation

public class CreateInfantry1Action: Action {
    
    public init() {
        super.init(id: 2, name: "Create Warrior")

        preconditions = []
        effects = []
        cost = 10
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(unit: Infantry1(theme: game.theme,
                                   playerId: player.playerId,
                                   name: "Warrior",
                                   position: Position(row: 0, col: 0)))
    }
    
    public override func clone() -> Action {
        let copy = CreateInfantry1Action()
        
        copy.cost = self.cost
        copy.scienceCost = self.scienceCost
        copy.numTurns = self.numTurns
        
        copy.preconditions = self.preconditions
        copy.effects = self.effects
        
        return copy
    }
}
