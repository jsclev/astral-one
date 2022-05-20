import Foundation

public class ResearchPotteryAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 1, name: "Research Pottery", game: game, player: player)

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        player.add(advanceName: name)
        
        for city in player.cities {
            city.addAvailable(action: BuildHangingGardensAction(game: game, player: player, city: city))
        }
        
        if player.hasResearched(advanceName: ResearchMapMakingAction(game: game, player: player).name) {
            player.addAvailable(researchAction: ResearchSeafaringAction(game: game, player: player))
        }
    }
    
    public override func clone() -> Action {
        let copy = ResearchCeremonialBurialAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
