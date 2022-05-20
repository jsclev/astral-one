import Foundation

public class ResearchConstructionAction: ResearchAction {
    
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Construction", game: game, player: player)
        
        preconditions = []
        effects = []
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        
//        for city in player.cities {
//            city.addAvailable(action: CreateInfantry2Action(game: game, player: player, city: city))
//            city.addAvailable(action: BuildColossusAction(game: game, player: player, city: city))
//        }
        
        player.addAvailable(researchAction: ResearchEngineeringAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchConstructionAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
