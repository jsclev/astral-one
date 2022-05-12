import Foundation

public class Infantry6: Unit {
    public init(theme: Theme,
                playerId: Int,
                name: String,
                position: Position) {
        super.init(theme: theme,
                   playerId: playerId,
                   tiledId: 101,
                   name: name,
                   assetName: "Units/Infantry/infantry-6",
                   cost: 20,
                   maxHp: 10,
                   attackRating: 1,
                   defense: 2,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
