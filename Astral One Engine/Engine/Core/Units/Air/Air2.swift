import Foundation

public class Air2: Unit {
    public init(theme: Theme,
                playerId: Int,
                name: String,
                row: Int,
                col: Int) {
        super.init(theme: theme,
                   playerId: playerId,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Air/air-2",
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
