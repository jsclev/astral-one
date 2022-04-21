import Foundation

public class BasicDefensiveGround: Unit {
    public init(playerId: Int, name: String, row: Int, col: Int) {
        super.init(playerId: playerId,
                   tiledId: 101,
                   name: name,
                   cost: 20,
                   maxHp: 10,
                   attackRating: 1,
                   defenseRating: 2,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
