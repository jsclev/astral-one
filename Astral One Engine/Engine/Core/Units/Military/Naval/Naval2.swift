import Foundation

public class Naval2: Unit {
    public init(playerId: Int,
                name: String,
                row: Int,
                col: Int) {
        super.init(playerId: playerId,
                   tiledId: 100,
                   name: name,
                   assetName: "naval-2",
                   cost: 40,
                   maxHp: 10,
                   attackRating: 2,
                   defenseRating: 1,
                   fp: 1,
                   maxMovementPoints: 3.0,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
