import Foundation

public class Naval1: Unit {
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
                   assetName: "Units/Naval/naval-1",
                   cost: 40,
                   maxHp: 10,
                   attack: 1,
                   defense: 1,
                   fp: 1,
                   maxMovementPoints: 3.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}