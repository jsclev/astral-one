import Foundation

public class Settler: Builder {
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
        if canMove(to: to) {
            position = to
            
            movementPoints -= player.map.tile(at: to).movementCost
        }
    }
    
    public override func canMove(to: Position) -> Bool {
        if player.map.tile(at: to).terrain.type == TerrainType.Ocean ||
            player.map.tile(at: to).terrain.type == TerrainType.Glacier {
            return false
        }
        
        return movementPoints >= player.map.tile(at: to).movementCost
    }
    
    public override func clone() -> Unit {
        return Settler(id: id,
                       player: player,
                       theme: theme,
                       name: name,
                       position: position)
    }
}
