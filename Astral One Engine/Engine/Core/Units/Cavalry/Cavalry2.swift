import Foundation

public class Cavalry2: Unit {
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
    
    public override func clone() -> Unit {
        return Cavalry2(player: player,
                        theme: theme,
                        name: name,
                        position: position)
    }
}
