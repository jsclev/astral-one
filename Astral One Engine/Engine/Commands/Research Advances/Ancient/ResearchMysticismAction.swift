import Foundation

public class ResearchMysticismAction: ResearchAction {
    
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Mysticism", game: game, player: player)
        
        preconditions = []
        effects = []
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)

    }
    
    public override func clone() -> Action {
        let copy = ResearchMysticismAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
