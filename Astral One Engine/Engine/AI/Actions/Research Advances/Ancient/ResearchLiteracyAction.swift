import Foundation

public class ResearchLiteracyAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Literacy")
        
        preconditions = []
        effects = []
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        
    }
    
    public override func clone() -> Action {
        let copy = ResearchLiteracyAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
