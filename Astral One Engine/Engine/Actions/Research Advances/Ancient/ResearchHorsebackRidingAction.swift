import Foundation

public class ResearchHorsebackRidingAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Horseback Riding", game: game, player: player)

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)

        for city in player.cities {
            city.addAvailable(action: CreateCavalry1Action(game: game, player: player, city: city))
        }
        
        if player.hasResearched(advanceName: ResearchFeudalismAction(game: game, player: player).name) {
            player.addAvailable(researchAction: ResearchChivalryAction(game: game, player: player))
        }
        
        player.addAvailable(researchAction: ResearchTheWheelAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchHorsebackRidingAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
