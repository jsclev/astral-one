import Foundation

public class ResearchFeudalismAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Feudalism", game: game, player: player)

        preconditions = [
            "advance_unlocked_warrior_code"
        ]
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        
        for city in player.map.cities {
            city.addAvailable(action: CreateInfantry4Action(game: game, player: player, city: city))
        }

        player.addAvailable(researchAction: ResearchChivalryAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchFeudalismAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
