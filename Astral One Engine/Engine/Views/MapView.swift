import SpriteKit
import AVFoundation
import GameplayKit

public class MapView {
    var scene: SKScene!
    let map: Map
    var debug = true
    var cameraScale = 1.0
    var initialCameraScale = 1.0
    let tilesetName: String = "Sci-Fi Tile Set"
    let filename: String = "freeland"
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
    let tileset: SKTileSet
    var mapIconsTileset: SKTileSet!
    var pathMap: SKTileMapNode
    var mapIcons: SKTileMapNode
    let tileSize = CGSize(width: 96, height: 48)
    var startPosition = SIMD2<Int32>(0, 0)
    var endPosition = SIMD2<Int32>(0, 0)
    
    public init(map: Map, tileset: SKTileSet) {
        self.map = map
        
        self.tileset = tileset
        pathMap = SKTileMapNode(tileSet: tileset,
                                columns: map.width,
                                rows: map.height,
                                tileSize: tileSize)
        pathMap.name = "terrain"
        pathMap.zPosition = Layer.unitPath
        pathMap.position = CGPoint.zero
        pathMap.enableAutomapping = true
        
        mapIconsTileset = SKTileSet(named: mapIconsTilesetName)
        mapIcons = SKTileMapNode(tileSet: mapIconsTileset,
                                 columns: map.width,
                                 rows: map.height,
                                 tileSize: tileSize)
        mapIcons.name = "map-icons"
        mapIcons.zPosition = Layer.unitPath2
        mapIcons.position = CGPoint.zero
        mapIcons.enableAutomapping = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    public func getCenterPoint(row: Int, col: Int) -> CGPoint {
        return mapIcons.centerOfTile(atColumn: col, row: row)
    }
    
    public func setScene(scene: SKScene) throws {
        self.scene = scene
        
        var terrainMaps: [SKTileMapNode] = []
        
        for layer in 0..<map.getNumLayers() {
            let terrainMap = SKTileMapNode(tileSet: tileset,
                                           columns: map.width,
                                           rows: map.height,
                                           tileSize: tileSize)
            terrainMap.name = "terrain_\(layer)"
            terrainMap.zPosition = Layer.terrain + CGFloat(layer)
            terrainMap.position = CGPoint.zero
            terrainMap.enableAutomapping = true
            
            terrainMaps.append(terrainMap)
        }
        
        let unitsMap = SKTileMapNode(tileSet: tileset,
                                     columns: map.width,
                                     rows: map.height,
                                     tileSize: tileSize)
        unitsMap.name = "units"
        unitsMap.zPosition = Layer.units
        unitsMap.position = CGPoint.zero
        unitsMap.enableAutomapping = true
        
        for row in 0..<map.height {
            for col in 0..<map.width {
                let tile = try map.tile(row: row, col: col)
                
                //                print(tile.terrain.description)
                
                if let tileGroup = tileset.tileGroups.first(where: { $0.name == tile.terrain.name }) {
                    // Make sure we are setting the tile on the correct layered terrain map
                    let terrainMap = terrainMaps[0]
                    
                    terrainMap.setTileGroup(tileGroup, forColumn: col, row: row)
                }
                else {
                    fatalError("Unable to find tile group \"\(tile.terrain.name)\"")
                }
                
                for unit in tile.getUnits() {
                    print("Adding unit with name \(unit.name)")
                    if let tileGroup = tileset.tileGroups.first(where: { $0.name == unit.name }) {
                        unitsMap.setTileGroup(tileGroup, forColumn: col, row: row)
                    }
                    else {
                        fatalError("Unable to find tile group \(unit.name)")
                    }
                }
            }
        }
        
        for terrainMap in terrainMaps {
            scene.addChild(terrainMap)
        }
        
        
        //        scene.addChild(unitsMap)
        //        scene.addChild(pathMap)
        //        scene.addChild(mapIcons)
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ss.SSS"
        print(string + formatter.string(from: date))
    }
    
}
