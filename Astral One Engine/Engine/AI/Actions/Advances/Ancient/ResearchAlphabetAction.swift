import Foundation

public class ResearchAlphabetAction: Action {
    public init() {
        super.init(id: 2, name: "Research Alphabet")
        
        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(action: self)

        player.addAvailable(action: ResearchMapMakingAction())
        player.addAvailable(action: ResearchWritingAction())
        player.addAvailable(action: ResearchCodeOfLawsAction())
        player.addAvailable(action: ResearchWritingAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchAlphabetAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
