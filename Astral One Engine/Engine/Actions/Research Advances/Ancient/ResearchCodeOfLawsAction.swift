import Foundation

public class ResearchCodeOfLawsAction: ResearchAction {
    
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Code of Laws", game: game, player: player)
        
        preconditions = []
        effects = []
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)

        player.addAvailable(researchAction: ResearchMonarchyAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchCodeOfLawsAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
