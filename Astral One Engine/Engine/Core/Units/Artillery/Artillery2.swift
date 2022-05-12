import Foundation

public class Artillery2: Unit {
    public init(theme: Theme,
                playerId: Int,
                name: String,
                position: Position) {
        super.init(theme: theme,
                   playerId: playerId,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Artillery/artillery-2",
                   cost: 40,
                   maxHp: 10,
                   attackRating: 1,
                   defense: 1,
                   fp: 1,
                   maxMovementPoints: 3.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
