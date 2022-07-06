import Foundation

public class ResearchBronzeWorkingAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 1, name: "Research Bronze Working", game: game, player: player)

        preconditions = []
        
        effects = [
            "unit_unlocked_infantry2"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        
        for city in player.map.cities {
            // city.addAvailable(action: CreateInfantry2Command(game: game, player: player, city: city))
            city.addAvailable(action: BuildColossusAction(game: game, player: player, city: city))
        }
        
        if player.hasResearched(advanceName: ResearchWarriorCodeAction(game: game, player: player).name) {
            player.addAvailable(researchAction: ResearchIronWorkingAction(game: game, player: player))
        }
        
        player.addAvailable(researchAction: ResearchCurrencyAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchBronzeWorkingAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
