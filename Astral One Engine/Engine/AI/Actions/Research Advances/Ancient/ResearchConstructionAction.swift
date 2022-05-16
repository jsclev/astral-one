import Foundation

public class ResearchConstructionAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Construction")
        
        preconditions = []
        effects = []
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        
    }
    
    public override func clone() -> Action {
        let copy = ResearchConstructionAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
