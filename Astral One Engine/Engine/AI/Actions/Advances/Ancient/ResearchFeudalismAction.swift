import Foundation

public class ResearchFeudalismAction: Action {
    public init() {
        super.init(id: 2, name: "Research Feudalism")

        preconditions = [
            "advance_unlocked_warrior_code"
        ]
        
        effects = [
            "unit_unlocked_cavalry1"
        ]
        
        cost = 0
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        player.removeAvailable(action: self)

        player.addAvailable(action: ResearchChivalryAction())
    }
    
    
}
