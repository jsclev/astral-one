import Foundation

public class Cavalry5: Unit {
    public init(theme: Theme,
                playerId: Int,
                name: String,
                row: Int,
                col: Int) {
        super.init(theme: theme,
                   playerId: playerId,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Cavalry/cavalry-5",
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
