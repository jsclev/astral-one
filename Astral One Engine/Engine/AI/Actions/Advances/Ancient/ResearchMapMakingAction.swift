import Foundation

public class ResearchMapMakingAction: Action {
    public init() {
        super.init(id: 2, name: "Research Map Making")

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
        
        if player.hasResearched(advanceName: ResearchAlphabetAction().name) {
            player.addAvailable(action: ResearchSeafaringAction())
        }
        
        player.addAvailable(action: ResearchSeafaringAction())

    }
    
    public override func clone() -> Action {
        let copy = ResearchMapMakingAction()
        
        copy.cost = self.cost
        copy.scienceCost = self.scienceCost
        copy.numTurns = self.numTurns
        
        copy.preconditions = self.preconditions
        copy.effects = self.effects
        
        return copy
    }
}
