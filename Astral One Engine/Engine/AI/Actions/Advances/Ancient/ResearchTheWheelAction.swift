import Foundation

public class ResearchTheWheelAction: Action {
    public init() {
        super.init(id: 2, name: "Research The Wheel")

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry2"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(action: self)
    }
    
    public override func clone() -> Action {
        let copy = ResearchTheWheelAction()
        
        copy.cost = self.cost
        copy.scienceCost = self.scienceCost
        copy.numTurns = self.numTurns
        
        copy.preconditions = self.preconditions
        copy.effects = self.effects
        
        return copy
    }
}
