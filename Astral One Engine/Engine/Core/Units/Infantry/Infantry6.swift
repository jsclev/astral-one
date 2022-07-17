import Foundation

public class Infantry6: Unit {
    /*
     In Civilization II this is equivalent to a Musketeers unit.
     */
    public convenience init(player: Player,
                            theme: Theme,
                            name: String,
                            position: Position) {
        self.init(id: Constants.noId,
                  player: player,
                  theme: theme,
                  name: name,
                  position: position)
    }
    
    public init(id: Int,
                player: Player,
                theme: Theme,
                name: String,
                position: Position) {
        super.init(id: id,
                   player: player,
                   theme: theme,
                   tiledId: 101,
                   name: name,
                   assetName: "Units/Infantry/infantry-6",
                   cost: 30,
                   maxHp: 20,
                   attack: 3,
                   defense: 3,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
