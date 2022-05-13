import Foundation

public class ResearchMasonryAction: Action {
    
    public init() {
        super.init(id: 2, name: "Research Masonry")

        preconditions = [
            "has_barracks"
        ]
        
        effects = [
            "advance_unlocked_masonry"
        ]
    }
    
    public override func execute(game: Game, player: Player) {
        player.addAvailable(action: BuildWallsAction())
        
        player.removeAvailable(action: self)
    }
    
    public override func clone() -> Action {
        let copy = ResearchMasonryAction()
        
        copy.cost = self.cost
        copy.scienceCost = self.scienceCost
        copy.numTurns = self.numTurns
        
        copy.preconditions = self.preconditions
        copy.effects = self.effects
        
        return copy
    }
}
