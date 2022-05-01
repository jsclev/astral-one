import Foundation

public class Naval3: Unit {
    public init(playerId: Int,
                name: String,
                row: Int,
                col: Int) {
        super.init(playerId: playerId,
                   tiledId: 100,
                   name: name,
                   assetName: "naval-3",
                   cost: 60,
                   maxHp: 30,
                   attackRating: 4,
                   defenseRating: 4,
                   fp: 1,
                   maxMovementPoints: 4.0,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
