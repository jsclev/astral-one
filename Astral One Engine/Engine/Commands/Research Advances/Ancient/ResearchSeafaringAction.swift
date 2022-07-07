import Foundation

public class ResearchSeafaringAction: ResearchAction {
    
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Seafaring", game: game, player: player)
        
        preconditions = []
        effects = []
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        
//        for city in player.map.cities {
            // city.addAvailable(action: CreateExplorerCommand(game: game, player: player, city: city))
            
//            if city.isCoastal {
//                city.addAvailable(action: BuildHarborAction(game: game, player: player, city: city))
//            }
//        }
    }
    
    public override func clone() -> Action {
        let copy = ResearchSeafaringAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
