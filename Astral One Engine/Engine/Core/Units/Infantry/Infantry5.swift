import Foundation

public class Infantry5: Unit {
    /*
     In Civilization II this is equivalent to a Legion unit.
     */
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
                   assetName: "Units/Infantry/infantry-5",
                   cost: 40,
                   maxHp: 10,
                   attack: 4,
                   defense: 2,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func clone() -> Unit {
        return Infantry5(game: game,
                         player: player,
                         theme: theme,
                         name: name,
                         position: position)
    }
}
