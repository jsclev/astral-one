import Foundation

public class ResearchHorsebackRidingAction: ResearchAction {
    public init() {
        super.init(id: 2, name: "Research Horseback Riding")

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)

        for city in player.cities {
            city.addAvailable(action: CreateCavalry1Action(city: city))
        }
        
        if player.hasResearched(advanceName: ResearchFeudalismAction().name) {
            player.addAvailable(researchAction: ResearchChivalryAction())
        }
        
        player.addAvailable(researchAction: ResearchTheWheelAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchHorsebackRidingAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
