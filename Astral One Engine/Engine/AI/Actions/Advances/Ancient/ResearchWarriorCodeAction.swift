import Foundation

public class ResearchWarriorCodeAction: ResearchAction {
    public init() {
        super.init(id: 2, name: "Research Warrior Code")

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)
        
        for city in player.cities {
            city.addAvailable(action: CreateInfantry3Action(city: city))
        }

        if player.hasResearched(advanceName: ResearchBronzeWorkingAction().name) {
            player.addAvailable(researchAction: ResearchIronWorkingAction())
        }
        
        player.addAvailable(researchAction: ResearchFeudalismAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchCeremonialBurialAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
