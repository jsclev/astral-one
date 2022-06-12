import Foundation

public class Settler: CityCreator {
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
                   assetName: "Units/Misc/city-creator",
                   cost: 10,
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
    
    public override func move(to: Position) {
        position = to
        
        if game.map.tile(at: position).terrain.type == TerrainType.Mountains {
            if let index = availableCommands.firstIndex(where: {$0.commandId == 1}) {
                availableCommands.remove(at: index)
            }
        }
    }
    
    public override func clone() -> Unit {
        return Settler(game: game,
                         player: player,
                         theme: theme,
                         name: name,
                         position: position)
    }
}