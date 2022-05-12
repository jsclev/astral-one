import Foundation

public class ResearchFeudalismAction: Action {
    public override init() {
        super.init()
        
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
        player.add(advance: Advance())
    }
    
    
}
