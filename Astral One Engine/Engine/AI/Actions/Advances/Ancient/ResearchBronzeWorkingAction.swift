import Foundation

public class ResearchBronzeWorkingAction: ResearchAction {
    public init() {
        super.init(id: 1, name: "Research Bronze Working")

        preconditions = []
        
        effects = [
            "unit_unlocked_infantry2"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)
        
        for city in player.cities {
            city.addAvailable(action: CreateInfantry2Action(city: city))
        }
        
        if player.hasResearched(advanceName: ResearchWarriorCodeAction().name) {
            player.addAvailable(researchAction: ResearchIronWorkingAction())
        }
        
        player.addAvailable(researchAction: ResearchCurrencyAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchBronzeWorkingAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
