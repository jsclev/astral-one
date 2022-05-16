import Foundation

public class ResearchAlphabetAction: ResearchAction {
    public init() {
        super.init(id: 2, name: "Research Alphabet")
        
        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)

        player.addAvailable(researchAction: ResearchMapMakingAction())
        player.addAvailable(researchAction: ResearchWritingAction())
        player.addAvailable(researchAction: ResearchCodeOfLawsAction())
        player.addAvailable(researchAction: ResearchWritingAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchAlphabetAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
