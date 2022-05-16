import Foundation

public class ResearchTheWheelAction: ResearchAction {
    public init() {
        super.init(id: 2, name: "Research The Wheel")

        preconditions = []
        
        effects = [
            "unit_unlocked_cavalry2"
        ]
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(researchAction: self)
        
        for city in player.cities {
            city.addAvailable(action: CreateCavalry2Action(city: city))
        }
        
        player.addAvailable(researchAction: ResearchEngineeringAction())
    }
    
    public override func clone() -> Action {
        let copy = ResearchTheWheelAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
