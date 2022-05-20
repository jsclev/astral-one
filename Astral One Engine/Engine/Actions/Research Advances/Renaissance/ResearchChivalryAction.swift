import Foundation

public class ResearchChivalryAction: ResearchAction {
    
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Chivalry", game: game, player: player)
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        player.addAvailable(researchAction: ResearchLeadershipAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchChivalryAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
