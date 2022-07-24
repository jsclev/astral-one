import Foundation

public class ResearchMapMakingAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Map Making", game: game, player: player)

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        player.add(advanceName: name)
        
//        for city in player.map.cities {
//            if city.isCoastal {
//                city.addAvailable(action: CreateNaval1Action(game: game, player: player, city: city))
//            }
//        }
        
        if player.hasResearched(advanceName: ResearchAlphabetAction(game: game, player: player).name) {
            player.addAvailable(researchAction: ResearchSeafaringAction(game: game, player: player))
        }
        
        player.addAvailable(researchAction: ResearchSeafaringAction(game: game, player: player))

    }
    
    public override func clone() -> Action {
        let copy = ResearchMapMakingAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
