import Foundation

public class Naval4: Unit {
    public init(theme: Theme,
                playerId: Int,
                name: String,
                row: Int,
                col: Int) {
        super.init(theme: theme,
                   playerId: playerId,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Naval/naval-4",
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
