import Foundation

public class ResearchPolytheismAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Polytheism", game: game, player: player)
        
        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)

        player.addAvailable(researchAction: ResearchMapMakingAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchWritingAction(game: game, player: player))
        
    }
    
    public override func clone() -> Action {
        let copy = ResearchAlphabetAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
