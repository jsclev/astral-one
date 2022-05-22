import Foundation

public class ResearchAlphabetAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Alphabet", game: game, player: player)
        
        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)

        player.startResearching(advanceType: AdvanceType.Alphabet)
        
        player.addAvailable(researchAction: ResearchMapMakingAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchWritingAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchCodeOfLawsAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchWritingAction(game: game, player: player))
        
        player.completeResearch(advanceType: AdvanceType.Alphabet)
    }
    
    public override func clone() -> Action {
        let copy = ResearchAlphabetAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
