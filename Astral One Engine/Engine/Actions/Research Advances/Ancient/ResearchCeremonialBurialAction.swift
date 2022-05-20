import Foundation

public class ResearchCeremonialBurialAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Ceremonial Burial", game: game, player: player)

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
    }
    
    public override func clone() -> Action {
        let copy = ResearchCeremonialBurialAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
