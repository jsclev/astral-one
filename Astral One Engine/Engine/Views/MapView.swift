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
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
    let tileset: SKTileSet
    var mapIconsTileset: SKTileSet!
    var pathMap: SKTileMapNode
    private let terrainLayer: BaseTerrainsMapLayer
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
                                tileSize: Constants.tileSize)
        pathMap.name = "terrain"
        pathMap.zPosition = Layer.unitPath
        pathMap.position = CGPoint.zero
        pathMap.enableAutomapping = true
        
        terrainLayer = BaseTerrainsMapLayer(player: player, scene: scene, tileSet: tileset)
        let _ = RiversMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = RoadsMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = CitiesMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = SpecialResourcesMapLayer(player: player, scene: scene, mapView: self, tileSet: tileset)
        let _ = TileStatsMapLayer(player: player, scene: scene, mapView: self)
        
        player.$units
            .sink(receiveValue: { units in
                if let unit = units.last {
                    self.renderUnit(unit: unit)
                }
            })
            .store(in: &cancellable)
        
        player.$cityCreators
            .sink(receiveValue: { cityCreators in
                if let cityCreator = cityCreators.last {
                    self.renderUnit(unit: cityCreator)
                }
            })
            .store(in: &cancellable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    public func getCenterPointOf(position: Position) -> CGPoint {
        return pathMap.centerOfTile(atColumn: position.col, row: position.row)
    }
    
    private func renderUnit(unit: Unit) {
        let unitNode = UnitNode(player: self.player,
                                unit: unit,
                                mapView: self)
        unitNode.position = self.getCenterPointOf(position: unit.position)
        unitNode.zPosition = Layer.units
        
        self.scene.addChild(unitNode)
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
    
    public func tap(location: CGPoint) -> Tile {
        return terrainLayer.tap(location: location)
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
