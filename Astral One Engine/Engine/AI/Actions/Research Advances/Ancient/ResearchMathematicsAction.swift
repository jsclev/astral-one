import Foundation

public class ResearchMathematicsAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Mathematics")
        
        preconditions = []
        effects = []
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {

    }
    
    public override func clone() -> Action {
        let copy = ResearchMathematicsAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
