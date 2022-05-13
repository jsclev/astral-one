import Foundation

public class ResearchWarriorCodeAction: Action {
    public init() {
        super.init(id: 2, name: "Research Warrior Code")

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.addAvailable(action: ResearchFeudalismAction())
        
        player.removeAvailable(action: self)
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
