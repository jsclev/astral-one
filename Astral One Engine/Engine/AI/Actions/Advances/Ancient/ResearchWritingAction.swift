import Foundation

public class ResearchWritingAction: Action {
    public init() {
        super.init(id: 2, name: "Research Writing")

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(action: self)
        player.add(advanceName: name)
        
        player.addAvailable(action: ResearchLiteracyAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchWritingAction()
        
        copy.cost = self.cost
        copy.scienceCost = self.scienceCost
        copy.numTurns = self.numTurns
        
        copy.preconditions = self.preconditions
        copy.effects = self.effects
        
        return copy
    }
}
