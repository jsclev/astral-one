import Foundation

public class ResearchTheWheelAction: ResearchAction {
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research The Wheel", game: game, player: player)

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry2"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)
        
//        for city in player.map.cities {
//            city.addAvailable(action: CreateCavalry2Action(game: game, player: player, city: city))
//        }
        
        player.addAvailable(researchAction: ResearchEngineeringAction(game: game, player: player))
    }
    
    public override func clone() -> Action {
        let copy = ResearchTheWheelAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
