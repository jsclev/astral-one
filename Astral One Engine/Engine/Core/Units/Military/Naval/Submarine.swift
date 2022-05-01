import Foundation

public class Submarine: Unit {
    public init(playerId: Int,
                name: String,
                row: Int,
                col: Int) {
        super.init(playerId: playerId,
                   tiledId: 100,
                   name: name,
                   assetName: "submarine",
                   cost: 160,
                   maxHp: 40,
                   attackRating: 12,
                   defenseRating: 12,
                   fp: 2,
                   maxMovementPoints: 4.0,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
