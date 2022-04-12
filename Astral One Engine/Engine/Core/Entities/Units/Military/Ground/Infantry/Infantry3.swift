import Foundation

public class Infantry3: Unit {
    public init(playerId: Int,
                name: String,
                row: Int,
                col: Int) {
        super.init(playerId: playerId,
                   name: name,
                   cost: 10,
                   maxHp: 10,
                   attackRating: 1,
                   defenseRating: 1,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
