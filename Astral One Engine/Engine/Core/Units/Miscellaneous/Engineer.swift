import Foundation

public class Engineer: Builder {
    public convenience init(game: Game,
                            player: Player,
                            theme: Theme,
                            name: String,
                            position: Position) {
        self.init(id: Constants.noId,
                  game: game,
                  player: player,
                  theme: theme,
                  name: name,
                  position: position)
    }
    
    public init(id: Int,
                game: Game,
                player: Player,
                theme: Theme,
                name: String,
                position: Position) {
        super.init(id: id,
                   game: game,
                   player: player,
                   theme: theme,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Misc/engineer",
                   cost: 20,
                   maxHp: 10,
                   attack: 1,
                   defense: 1,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
