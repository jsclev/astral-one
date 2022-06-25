import Foundation

public class Naval2: BaseNavalTransport {
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
                   assetName: "Units/Naval/naval-2",
                   cost: 40,
                   maxHp: 10,
                   attack: 2,
                   defense: 1,
                   fp: 1,
                   maxMovementPoints: 3.0,
                   position: position,
                   maxCapacity: 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func clone() -> Unit {
        return Naval2(game: game,
                         player: player,
                         theme: theme,
                         name: name,
                         position: position)
    }
}
