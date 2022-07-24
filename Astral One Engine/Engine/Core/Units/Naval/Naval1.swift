import Foundation

/// Equivalent to Civilization II Trireme unit
public class Naval1: BaseNavalTransport {
    public convenience init(player: Player,
                            theme: Theme,
                            skin: Skin,
                            name: String,
                            position: Position) {
        self.init(id: Constants.noId,
                  player: player,
                  theme: theme,
                  skin: skin,
                  name: name,
                  position: position)
    }
    
    public init(id: Int,
                player: Player,
                theme: Theme,
                skin: Skin,
                name: String,
                position: Position) {
        super.init(id: id,
                   player: player,
                   theme: theme,
                   skin: skin,
                   tiledId: 100,
                   name: name,
                   assetName: "Units/Naval/naval-1",
                   cost: 40,
                   maxHp: 10,
                   attack: 1,
                   defense: 1,
                   fp: 1,
                   maxMovementPoints: 3.0,
                   position: position,
                   maxCapacity: 2)
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
    
    public override func clone() -> Unit {
        return Naval1(player: player,
                      theme: theme,
                      name: name,
                      position: position)
    }
}
