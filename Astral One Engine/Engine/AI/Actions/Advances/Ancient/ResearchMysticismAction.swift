import Foundation

public class ResearchMysticismAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Mysticism")
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {

    }
    
    public override func clone() -> Action {
        let copy = ResearchMysticismAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
