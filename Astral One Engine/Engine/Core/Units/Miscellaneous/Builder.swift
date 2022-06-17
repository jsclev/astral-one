import Foundation

public class Builder: Unit {
    public override init(game: Game,
                         player: Player,
                         theme: Theme,
                         tiledId: Int,
                         name: String,
                         assetName: String,
                         cost: Double,
                         maxHp: Double,
                         attack: Double,
                         defense: Double,
                         fp: Double,
                         maxMovementPoints: Double,
                         position: Position) {
        super.init(game: game,
                   player: player,
                   theme: theme,
                   tiledId: tiledId,
                   name: name,
                   assetName: assetName,
                   cost: cost,
                   maxHp: maxHp,
                   attack: attack,
                   defense: defense,
                   fp: fp,
                   maxMovementPoints: maxMovementPoints,
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
    
    public var canCreateCity: Bool {
        return true
    }
    
    public var canBuildFortress: Bool {
        return true
    }
    
    public var canBuildRoad: Bool {
        return true
    }
    
    internal func buildFortress() {
        if canBuildFortress {
            player.map.tile(at: position).addFortress()
        }
    }
    
    internal func buildRoad() {
        if canBuildRoad {
            player.map.tile(at: position).addRoad()
        }
    }
    
    internal func buildRailroad() {
        if canBuildRoad {
            player.map.tile(at: position).addRailroad()
        }
    }
    
    public override func clone() -> Unit {
        let copy = Builder(game: game,
                               player: player,
                               theme: theme,
                               tiledId: tiledId,
                               name: name,
                               assetName: assetName,
                               cost: cost,
                               maxHp: maxHp,
                               attack: attack,
                               defense: defense,
                               fp: fp,
                               maxMovementPoints: maxMovementPoints,
                               position: position)
        
        return copy
    }
    
    
}
