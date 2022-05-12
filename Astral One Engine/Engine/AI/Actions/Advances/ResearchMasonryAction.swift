import Foundation

public class ResearchMasonryAction: Action {
    
    public override init() {
        super.init()
        
        preconditions = [
            "has_barracks"
        ]
        
        effects = [
            "advance_unlocked_masonry"
        ]
    }
    
    public override func execute(game: Game, player: Player) {
        player.add(advance: Advance())
    }
    
    public override func clone() -> Action {
        let copy = ResearchCeremonialBurialAction()
        
        copy.cost = self.cost
        copy.scienceCost = self.scienceCost
        copy.numTurns = self.numTurns
        
        copy.preconditions = self.preconditions
        copy.effects = self.effects
        
        return copy
    }
}
