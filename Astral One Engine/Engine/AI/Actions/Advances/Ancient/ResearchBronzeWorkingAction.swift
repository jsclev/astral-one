import Foundation

public class ResearchBronzeWorkingAction: Action {
    public init() {
        super.init(id: 1, name: "Research Bronze Working")

        preconditions = []
        
        effects = [
            "unit_unlocked_infantry2"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(action: self)
    }
    
    public override func clone() -> Action {
        let copy = ResearchBronzeWorkingAction()
        
        copy.cost = self.cost
        copy.scienceCost = self.scienceCost
        copy.numTurns = self.numTurns
        
        copy.preconditions = self.preconditions
        copy.effects = self.effects
        
        return copy
    }
}
