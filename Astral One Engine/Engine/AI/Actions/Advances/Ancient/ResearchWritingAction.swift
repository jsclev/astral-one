import Foundation

public class ResearchWritingAction: ResearchAction {
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
        player.removeAvailable(researchAction: self)
        player.add(advanceName: name)
        
        player.addAvailable(researchAction: ResearchLiteracyAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchWritingAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
