import Foundation

public class ResearchChivalryAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Chivalry")
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)
        player.addAvailable(researchAction: ResearchLeadershipAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchChivalryAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
