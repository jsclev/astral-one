import Foundation

public class ResearchEngineeringAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Engineering")
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
//        player.removeAvailable(researchAction: self)
//
//        for city in player.cities {
//            city.addAvailable(action: CreateInfantry3Action(city: city))
//        }
//
//        if player.hasResearched(advanceName: ResearchBronzeWorkingAction().name) {
//            player.addAvailable(researchAction: ResearchIronWorkingAction())
//        }
//
//        player.addAvailable(researchAction: ResearchFeudalismAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchEngineeringAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
