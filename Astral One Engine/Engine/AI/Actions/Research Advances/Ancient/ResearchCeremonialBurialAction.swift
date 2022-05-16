import Foundation

public class ResearchCeremonialBurialAction: ResearchAction {
    public init() {
        super.init(id: 2, name: "Research Ceremonial Burial")

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)
    }
    
    public override func clone() -> Action {
        let copy = ResearchCeremonialBurialAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
