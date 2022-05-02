import Foundation

public class Cavalry6: Unit {
    public init(playerId: Int,
                name: String,
                row: Int,
                col: Int) {
        super.init(playerId: playerId,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Cavalry/cavalry-6",
                   cost: 80,
                   maxHp: 30,
                   attackRating: 10,
                   defenseRating: 5,
                   fp: 1,
                   maxMovementPoints: 3.0,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
