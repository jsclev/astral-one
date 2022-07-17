import Foundation

public class Naval8: Unit {
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
                   assetName: "Units/Naval/naval-8",
                   cost: 160,
                   maxHp: 40,
                   attack: 12,
                   defense: 12,
                   fp: 2,
                   maxMovementPoints: 4.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
