import Foundation

public class ResearchLeadershipAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Leadership")
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {

    }
    
    public override func clone() -> Action {
        let copy = ResearchLeadershipAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
