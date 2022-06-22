import Foundation

public class ResearchLeadershipAction: ResearchAction {
    
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Leadership", game: game, player: player)
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)

    }
    
    public override func clone() -> Action {
        let copy = ResearchLeadershipAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
