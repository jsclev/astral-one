import Foundation

public class ResearchMapMakingAction: ResearchAction {
    public init() {
        super.init(id: 2, name: "Research Map Making")

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
        
        for city in player.cities {
            if city.isCoastal {
                city.addAvailable(action: CreateNaval1Action(city: city))
            }
        }
        
        if player.hasResearched(advanceName: ResearchAlphabetAction().name) {
            player.addAvailable(researchAction: ResearchSeafaringAction())
        }
        
        player.addAvailable(researchAction: ResearchSeafaringAction())

    }
    
    public override func clone() -> Action {
        let copy = ResearchMapMakingAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
