import Foundation

public class ResearchUniversityAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research University")
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        
    }
    
    public override func clone() -> Action {
        let copy = ResearchUniversityAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
