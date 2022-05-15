import Foundation

public class ResearchPotteryAction: ResearchAction {
    public init() {
        super.init(id: 1, name: "Research Pottery")

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)
        player.add(advanceName: name)
        
        if player.hasResearched(advanceName: ResearchMapMakingAction().name) {
            player.addAvailable(researchAction: ResearchSeafaringAction())
        }
    }
    
    public override func clone() -> Action {
        let copy = ResearchCeremonialBurialAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
