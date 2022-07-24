import Foundation

/// Equivalent to Civilization II Ironclad unit
public class Naval5: Unit {
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
                   assetName: "Units/Skins/Upgraded/Naval/naval-1",
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
