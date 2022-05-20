import Foundation

public class ResearchEngineeringAction: ResearchAction {
    
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Engineering", game: game, player: player)
        
        preconditions = []
        effects = []
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
//
//        for city in player.cities {
//            city.addAvailable(action: CreateInfantry3Action(city: city))
//        }
//
//        if player.hasResearched(advanceName: ResearchBronzeWorkingAction(game: game, player: player).name) {
//            player.addAvailable(researchAction: ResearchIronWorkingAction(game: game, player: player))
//        }
//
//        player.addAvailable(researchAction: ResearchFeudalismAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchEngineeringAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
