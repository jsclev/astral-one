import Foundation

public class ResearchFeudalismAction: ResearchAction {
    public init() {
        super.init(id: 2, name: "Research Feudalism")

        preconditions = [
            "advance_unlocked_warrior_code"
        ]
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)
        
        for city in player.cities {
            city.addAvailable(action: CreateInfantry4Action(city: city))
        }

        player.addAvailable(researchAction: ResearchChivalryAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchFeudalismAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
