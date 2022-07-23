import Foundation

/// Equivalent to Civilization II Galleon unit
public class Naval3: BaseNavalTransport {
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
                   assetName: "Units/Naval/naval-3",
                   cost: 60,
                   maxHp: 30,
                   attack: 4,
                   defense: 4,
                   fp: 1,
                   maxMovementPoints: 4.0,
                   position: position,
                   maxCapacity: 4)
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
        if player.map.tile(at: to).terrain.type != TerrainType.Ocean {
            return false
        }
        
        return movementPoints >= player.map.tile(at: to).movementCost
    }
}
