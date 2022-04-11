import Foundation

public class BasicDefensiveGround: Unit {
    public init(playerId: Int, name: String, row: Int, col: Int) {
        super.init(playerId: playerId,
                   name: name,
                   cost: 20,
                   hp: 10,
                   attackRating: 1,
                   defenseRating: 2,
                   firepower: 1,
                   movementPoints: 1.0,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
