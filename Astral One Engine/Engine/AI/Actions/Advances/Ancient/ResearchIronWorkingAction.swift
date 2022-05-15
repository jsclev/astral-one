import Foundation

public class ResearchIronWorkingAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Iron Working")
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        
    }
    
    public override func clone() -> Action {
        let copy = ResearchIronWorkingAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
