import Foundation

public class Infantry8: Unit {
    /*
     In Civilization II this is equivalent to a Mechanized Infantry unit.
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
                   assetName: "Units/Infantry/infantry-8",
                   cost: 50,
                   maxHp: 30,
                   attack: 6,
                   defense: 6,
                   fp: 1,
                   maxMovementPoints: 3.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
