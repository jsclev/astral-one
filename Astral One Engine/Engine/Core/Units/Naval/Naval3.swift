import Foundation

public class Naval3: BaseNavalTransport {
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
                   assetName: "Units/Naval/naval-3",
                   cost: 60,
                   maxHp: 30,
                   attack: 4,
                   defense: 4,
                   fp: 1,
                   maxMovementPoints: 4.0,
                   position: position,
                   maxCapacity: 4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
