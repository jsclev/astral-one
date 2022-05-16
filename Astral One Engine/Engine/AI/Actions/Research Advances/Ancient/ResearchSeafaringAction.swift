import Foundation

public class ResearchSeafaringAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Seafaring")
        
        preconditions = []
        effects = []
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)
        
        for city in player.cities {
            city.addAvailable(action: CreateExplorerAction(city: city))
            
            if city.isCoastal {
                city.addAvailable(action: BuildHarborAction(city: city))
            }
        }
    }
    
    public override func clone() -> Action {
        let copy = ResearchSeafaringAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
