import Foundation

public class Submarine: Unit {
    public init(theme: Theme,
                playerId: Int,
                name: String,
                position: Position) {
        super.init(theme: theme,
                   playerId: playerId,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Naval/submarine",
                   cost: 160,
                   maxHp: 40,
                   attackRating: 12,
                   defenseRating: 12,
                   fp: 2,
                   maxMovementPoints: 4.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
