import Foundation

public class Infantry2: Unit {
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
                   assetName: "Units/Infantry/infantry-2",
                   cost: 20,
                   maxHp: 1,
                   attack: 1,
                   defense: 2,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func clone() -> Unit {
        return Infantry2(game: game,
                         player: player,
                         theme: theme,
                         name: name,
                         position: position)
    }
}
