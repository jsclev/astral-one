import Foundation

public class ResearchWritingAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Writing", game: game, player: player)

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        player.add(advanceName: name)
        
        player.addAvailable(researchAction: ResearchLiteracyAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchWritingAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
