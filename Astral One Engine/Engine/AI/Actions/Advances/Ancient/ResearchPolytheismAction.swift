import Foundation

public class ResearchPolytheismAction: ResearchAction {
    public init() {
        super.init(id: 2, name: "Research Polytheism")
        
        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.addAvailable(researchAction: ResearchMapMakingAction())
        player.addAvailable(researchAction: ResearchWritingAction())
        
        player.removeAvailable(researchAction: self)
    }
    
    public override func clone() -> Action {
        let copy = ResearchAlphabetAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
