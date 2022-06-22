import Foundation

public class ResearchMonarchyAction: ResearchAction {
    
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Monarchy", game: game, player: player)
        
        preconditions = []
        effects = []
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)

    }
    
    public override func clone() -> Action {
        let copy = ResearchMonarchyAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
