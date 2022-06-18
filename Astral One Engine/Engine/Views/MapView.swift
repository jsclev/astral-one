import Combine
import SpriteKit

public class MapView {
    var scene: SKScene
    let player: Player
    let mapName = "terrain"
    let tileset: SKTileSet
    var pathMap: SKTileMapNode
    private let terrainLayer: BaseTerrainsMapLayer
    private var cancellable = Set<AnyCancellable>()
    
    public init(player: Player, scene: SKScene, tileset: SKTileSet) {
        self.player = player
        self.scene = scene
        self.tileset = tileset
        
        pathMap = SKTileMapNode(tileSet: tileset,
                                columns: player.map.width,
                                rows: player.map.height,
                                tileSize: Constants.tileSize)
        pathMap.name = "terrain"
        pathMap.zPosition = Layer.unitPath
        pathMap.position = CGPoint.zero
        pathMap.enableAutomapping = true
        
        terrainLayer = BaseTerrainsMapLayer(player: player, scene: scene, tileSet: tileset)
        let _ = RiversMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = RoadsMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = CitiesMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = FortressesMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = SpecialResourcesMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = UnitsMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = TileStatsMapLayer(player: player, scene: scene, mapView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    public func getCenterPointOf(position: Position) -> CGPoint {
        return pathMap.centerOfTile(atColumn: position.col, row: position.row)
    }
    
    public func tap(location: CGPoint) -> Tile {
        return terrainLayer.tap(location: location)
    }
}
