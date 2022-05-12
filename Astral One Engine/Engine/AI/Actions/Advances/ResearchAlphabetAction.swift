import Foundation

public class ResearchAlphabetAction: Action {
    public override init() {
        super.init()
        
        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(advance: Advance())
    }
    
    public override func clone() -> Action {
        let copy = ResearchAlphabetAction()
        
        copy.cost = self.cost
        copy.scienceCost = self.scienceCost
        copy.numTurns = self.numTurns
        
        copy.preconditions = self.preconditions
        copy.effects = self.effects
        
        return copy
    }
}
