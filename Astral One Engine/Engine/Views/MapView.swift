import SpriteKit
import AVFoundation
import GameplayKit
import Combine

public class MapView {
    var scene: SKScene!
    let player: Player
    var debug = true
    var cameraScale = 1.0
    var initialCameraScale = 1.0
    let filename: String = "freeland"
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
    let tileset: SKTileSet
    var mapIconsTileset: SKTileSet!
    var pathMap: SKTileMapNode
    let tileSize = CGSize(width: 96, height: 48)
    private let terrainLayer: TileMapLayer
    var startPosition = SIMD2<Int32>(0, 0)
    var endPosition = SIMD2<Int32>(0, 0)
    private var cancellable = Set<AnyCancellable>()
    
    public init(player: Player, scene: SKScene, tileset: SKTileSet) {
        self.player = player
        self.scene = scene
        self.tileset = tileset
        
        pathMap = SKTileMapNode(tileSet: tileset,
                                columns: player.map.width,
                                rows: player.map.height,
                                tileSize: tileSize)
        pathMap.name = "terrain"
        pathMap.zPosition = Layer.unitPath
        pathMap.position = CGPoint.zero
        pathMap.enableAutomapping = true
        
        terrainLayer = TileMapLayer(player: player, scene: scene, tileSet: tileset)
        let _ = CityMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = SpecialResourceMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = TileStatsMapLayer(player: player, scene: scene, mapView: self)
        
//        player.$units
//            .dropFirst()
//            .sink(receiveValue: { units in
//                if let unit = units.last {
//                    let unitNode = UnitNode(game: self.game,
//                                            unit: unit,
//                                            mapView: self)
//                    unitNode.position = self.getCenterPointOf(position: unit.position)
//                    unitNode.zPosition = Layer.contextMenu
//                    self.scene.addChild(unitNode)
//                }
//            })
//            .store(in: &cancellable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    public func getCenterPointOf(position: Position) -> CGPoint {
        return pathMap.centerOfTile(atColumn: position.col, row: position.row)
    }
    
    public func setScene(scene: SKScene) {
//        self.scene = scene
//
//        var terrainMaps: [SKTileMapNode] = []
//
//        for layer in 0..<map.getNumLayers() {
//            let terrainMap = SKTileMapNode(tileSet: tileset,
//                                           columns: player.map.width,
//                                           rows: player.map.height,
//                                           tileSize: tileSize)
//            terrainMap.name = "terrain_\(layer)"
//            terrainMap.zPosition = Layer.terrain + CGFloat(layer)
//            terrainMap.position = CGPoint.zero
//            terrainMap.enableAutomapping = true
//
//            terrainMaps.append(terrainMap)
//        }
//
//        let unitsMap = SKTileMapNode(tileSet: tileset,
//                                     columns: map.width,
//                                     rows: map.height,
//                                     tileSize: tileSize)
//        unitsMap.name = "units"
//        unitsMap.zPosition = Layer.units
//        unitsMap.position = CGPoint.zero
//        unitsMap.enableAutomapping = true
        
        
        
//        for terrainMap in terrainMaps {
//            scene.addChild(terrainMap)
//        }
        
        
        //        scene.addChild(unitsMap)
        //        scene.addChild(pathMap)
        //        scene.addChild(mapIcons)
    }
    
    func clearMapIcons() {
//        for row in 0..<player.map.height {
//            for col in 0..<player.map.width {
//                if let _ = mapIcons.tileGroup(atColumn: col, row: row) {
//                    mapIcons.setTileGroup(nil, forColumn: col, row: row)
//                }
//
//                if let _ = pathMap.tileGroup(atColumn: col, row: row) {
//                    pathMap.setTileGroup(nil, forColumn: col, row: row)
//                }
//            }
//        }
    }
    
    public func tap(location: CGPoint) {
        terrainLayer.tap(location: location)
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ss.SSS"
        print(string + formatter.string(from: date))
    }
    
    //    func showAIPath(path: [GKGraphNode]) {
    //        let tileGroupName = "Fog"
    //
    //        for node in path {
    //            let theNode: GKGridGraphNode = node as! GKGridGraphNode
    //
    //            if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileGroupName }) {
    //                print("[\(theNode.gridPosition.y),\(theNode.gridPosition.x)]")
    //                pathMap.setTileGroup(tileGroup,
    //                                     forColumn: Int(theNode.gridPosition.y),
    //                                     row: Int(theNode.gridPosition.x))
    //            }
    //            else {
    //                fatalError("\"\(tileGroupName)\" tile group not found in \"\(tilesetName)\" tile set.")
    //            }
    //        }
    //    }
    
    //    func showRandomAIPaths() {
    //        //        print("About to calculate \(numPaths) paths: " + formatter.string(from: Date()))
    //        let numPaths: Int = 1000
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "HH:mm:ss.SSSS"
    //
    //        for _ in 0..<numPaths {
    //            let from = SIMD2<Int32>(Int32.random(in: 0..<Int32(pathMap.numberOfRows)),
    //                                    Int32.random(in: 0..<Int32(pathMap.numberOfColumns)))
    //            let to = SIMD2<Int32>(Int32.random(in: 0..<Int32(pathMap.numberOfRows)),
    //                                  Int32.random(in: 0..<Int32(pathMap.numberOfColumns)))
    //            let path: [GKGridGraphNode] = [] //game.getMap().findPath(from: from, to: to)
    //
    //            for node in path {
    //                let theNode: GKGridGraphNode = node as! GKGridGraphNode
    //
    //                if let tileGroup = tileset.tileGroups.first(where: { $0.name == "Fog"}) {
    //                    pathMap.setTileGroup(tileGroup,
    //                                         forColumn: Int(theNode.gridPosition.y),
    //                                         row: Int(theNode.gridPosition.x))
    //                }
    //            }
    //        }
    //        //        print("Done calculating \(numPaths) paths: " + formatter.string(from: Date()))
    //    }
    
}
