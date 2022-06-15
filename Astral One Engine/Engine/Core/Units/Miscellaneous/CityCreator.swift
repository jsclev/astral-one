import Foundation

public class CityCreator: Unit {
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
    
    public func canCreateCity() -> Bool {
        return true
    }
    
    public func buildNewCity(city: City) {
        if canCreateCity() {
            player.create(city: city, using: self)
        }
    }
    
    public override func clone() -> Unit {
        let copy = CityCreator(game: game,
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
