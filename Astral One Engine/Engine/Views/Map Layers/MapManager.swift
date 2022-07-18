import Combine
import SpriteKit

public class MapManager {
    var scene: SKScene
    let player: Player
    let tileset: SKTileSet
    private let terrainLayer: TerrainMapLayer
    private var cancellable = Set<AnyCancellable>()
    
    public init(game: Game, player: Player, scene: SKScene, tileset: SKTileSet) {
        self.player = player
        self.scene = scene
        self.tileset = tileset
        
        terrainLayer = TerrainMapLayer(player: player, scene: scene, tileSet: tileset)
        let _ = RiversMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = RoadsMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = CitiesMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = FortressesMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = SpecialResourcesMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = UnitMovementMapLayer(player: player, scene: scene, tileSet: tileset)
        let _ = UnitsMapLayer(game: game, player: player, scene: scene, mapManager: self, tileSet: tileset)
        let _ = TileCoordsMapLayer(game: game, player: player, scene: scene, mapView: self)
        let _ = AIDebugMapLayer(game: game, player: player, scene: scene, mapView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    public func getCenterOf(position: Position) -> CGPoint {
        return terrainLayer.getCenterOf(position: position)
    }
    
    public func getTile(at: CGPoint) -> Tile {
        return terrainLayer.tap(location: at)
    }
    
    public func getUnit(at: CGPoint) -> Unit? {
        let tile = getTile(at: at)
        
        for unit in player.cityCreators {
            if unit.position == tile.position {
                return unit
            }
        }
        
        return nil
    }
    
    public func getUnit(on: Tile) -> Unit? {
        for unit in player.cityCreators {
            if unit.position == on.position {
                return unit
            }
        }
        
        return nil
    }
}
