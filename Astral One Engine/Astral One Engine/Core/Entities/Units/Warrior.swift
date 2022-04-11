import Foundation
import GameplayKit

public class Warrior: Unit {
    public init(playerId: Int,
                row: Int,
                col: Int) {
        super.init(playerId: playerId,
                   name: "Warrior",
                   hp: 10,
                   attackRating: 1,
                   defenseRating: 1,
                   firepower: 1,
                   movementPoints: 1.0,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
