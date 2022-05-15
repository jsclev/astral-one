import Foundation

public class Cavalry2: Unit {
    public init(game: Game,
                player: Player,
                theme: Theme,
                name: String,
                position: Position) {
        super.init(game: game,
                   player: player,
                   theme: theme,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Cavalry/cavalry-2",
                   cost: 30,
                   maxHp: 30,
                   attack: 3,
                   defense: 1,
                   fp: 1,
                   maxMovementPoints: 2.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
