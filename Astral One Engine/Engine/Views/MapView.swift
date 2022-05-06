import SpriteKit
import AVFoundation
import GameplayKit

public class MapView {
    var scene: SKScene!
    let game: Game
    let map: Map
    var debug = true
    var cameraScale = 1.0
    var initialCameraScale = 1.0
//    let tilesetName: String = Constants.theme + " Tile Set"
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
    
    public init(game: Game, map: Map, tileset: SKTileSet) {
        self.game = game
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
//                    if row ==
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
    
    public func renderPlayer() {
        for player in game.players {
            for city in player.cities {
                let node = CityNode(game: game, city: city)
                node.position = getCenterPoint(row: city.row, col: city.col)
                node.zPosition = Layer.cities
                scene.addChild(node)
            }
            
            for creator in player.cityCreators {
                let node = FounderNode(game: game, cityCreator: creator)
                node.position = getCenterPoint(row: creator.row, col: creator.col)
                node.zPosition = Layer.contextMenu
                scene.addChild(node)
            }
            
            for unit in player.units {
                let unitNode = UnitNode(game: game, unit: unit)
                unitNode.position = getCenterPoint(row: unit.row, col: unit.col)
                unitNode.zPosition = Layer.contextMenu
                scene.addChild(unitNode)
            }
        }
    }
    
    func clearMapIcons() {
        for row in 0..<mapIcons.numberOfRows {
            for col in 0..<mapIcons.numberOfColumns {
                if let _ = mapIcons.tileGroup(atColumn: col, row: row) {
                    mapIcons.setTileGroup(nil, forColumn: col, row: row)
                }
                
                if let _ = pathMap.tileGroup(atColumn: col, row: row) {
                    pathMap.setTileGroup(nil, forColumn: col, row: row)
                }
            }
        }
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
