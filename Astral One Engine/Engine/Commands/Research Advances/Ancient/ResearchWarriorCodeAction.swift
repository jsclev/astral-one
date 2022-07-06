import Foundation

public class ResearchWarriorCodeAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Warrior Code", game: game, player: player)

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        
//        for city in player.map.cities {
//            city.addAvailable(action: CreateInfantry3Command(game: game, player: player, city: city))
//        }

        if player.hasResearched(advanceName: ResearchBronzeWorkingAction(game: game, player: player).name) {
            player.addAvailable(researchAction: ResearchIronWorkingAction(game: game, player: player))
        }
        
        player.addAvailable(researchAction: ResearchFeudalismAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchCeremonialBurialAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
