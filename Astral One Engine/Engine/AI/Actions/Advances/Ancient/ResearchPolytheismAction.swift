import Foundation

public class ResearchPolytheismAction: Action {
    public init() {
        super.init(id: 2, name: "Research Alphabet")
        
        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.addAvailable(action: ResearchMapMakingAction())
        player.addAvailable(action: ResearchWritingAction())
        
        player.removeAvailable(action: self)
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
