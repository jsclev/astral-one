import SpriteKit
import AVFoundation
import GameplayKit
import Astral_One_Engine

enum PathfinderState {
    case initialized
    case settingStartPosition
    case settingStopPosition
    case calculatingPath
}

class PathfinderScene: SKScene {
    var mapViewModel: MapViewModel
    var debug = true
    var gameCamera: PathfinderCamera!
    var cameraScale = 1.0
    var entityManager: EntityManager!
    var initialCameraScale = 1.0
    var pinchGestureRecognizer: UIPinchGestureRecognizer!
    let tilesetName: String = "Freeland Tile Set"
    let filename: String = "freeland"
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
    var tileset: SKTileSet!
    var mapIconsTileset: SKTileSet!
    var pathMap: SKTileMapNode
    var mapIcons: SKTileMapNode
    let tileSize: CGSize = CGSize(width: 96, height: 48)
    let rows: Int = 100
    let cols: Int = 100
    var state: PathfinderState = PathfinderState.initialized
    var game: Game = Game()
    var startPosition = SIMD2<Int32>(0, 0)
    var endPosition = SIMD2<Int32>(0, 0)
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        
        tileset = SKTileSet(named: tilesetName)
        pathMap = SKTileMapNode(tileSet: tileset,
                                columns: cols,
                                rows: rows,
                                tileSize: tileSize)
        pathMap.name = "terrain"
        pathMap.zPosition = Layer.unitPath
        pathMap.position = CGPoint.zero
        pathMap.enableAutomapping = true
        
        mapIconsTileset = SKTileSet(named: mapIconsTilesetName)
        mapIcons = SKTileMapNode(tileSet: mapIconsTileset,
                                 columns: cols,
                                 rows: rows,
                                 tileSize: tileSize)
        mapIcons.name = "map-icons"
        mapIcons.zPosition = Layer.unitPath2
        mapIcons.position = CGPoint.zero
        mapIcons.enableAutomapping = true
        
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    @objc func tap(recognizer: UITapGestureRecognizer){
        if recognizer.state != .ended {
            return
        }
        
        let recognizorLocation = recognizer.location(in: recognizer.view!)
        let location = self.convertPoint(fromView: recognizorLocation)
        let touchedNodes = nodes(at: location)
        
        if !touchedNodes.isEmpty && touchedNodes[0].name == "set-start-position" {
            clearMapIcons()
            state = PathfinderState.settingStartPosition
            return
        }
        else if !touchedNodes.isEmpty && touchedNodes[0].name == "calculate-path" {
            state = PathfinderState.calculatingPath
            let path = game.getMap().findPath(from: startPosition, to: endPosition)
            showAIPath(path: path)
            return
        }
        
        let tappedRow = mapIcons.tileRowIndex(fromPosition: location)
        let tappedCol = mapIcons.tileColumnIndex(fromPosition: location)
        
        if state == PathfinderState.settingStartPosition {
            let tileGroup = mapIconsTileset.tileGroups.first { $0.name == "Start Icon" }
            startPosition.y = Int32(tappedCol)
            startPosition.x = Int32(tappedRow)
            mapIcons.setTileGroup(tileGroup, forColumn: tappedCol, row: tappedRow)
            state = PathfinderState.settingStopPosition
        }
        else if state == PathfinderState.settingStopPosition {
            let tileGroup = mapIconsTileset.tileGroups.first { $0.name == "Stop Icon" }
            endPosition.y = Int32(tappedCol)
            endPosition.x = Int32(tappedRow)
            mapIcons.setTileGroup(tileGroup, forColumn: tappedCol, row: tappedRow)
            state = PathfinderState.calculatingPath
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
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        gameCamera = PathfinderCamera(entityManager)
        
        camera = gameCamera
        addChild(gameCamera)
        
        gameCamera.show()
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handleZoom))
        view.addGestureRecognizer(pinchGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        
        printDate(string: "Starting to parse Tiled XML files, and build traversal grid graph: ")
        game.importTiledMap(filename: filename)
        printDate(string: "Done parsing Tile XML, main traversal grid graph is parsed, now rendering map: ")

        renderMap(map: game.getMap())
        printDate(string: "Done rendering, now building Explorer-specific traversal graph: ")
        
//        let explorer = Explorer(game: game, position: SIMD2<Int32>(1, 1))
//        let path: [GKGraphNode] = explorer.getPath(to: SIMD2<Int32>(3, 3))
        printDate(string: "Done building Explorer-specific traversal graph, rendering path: ")

//        showAIPath(path: path)
        printDate(string: "About to prune main graph: ")
        game.prune()
        printDate(string: "Done pruning main graph: ")
        
        let user = game.db.gameDao.getCurrentUnit()
        let gameActions = game.db.gameActionDao.getActions(gameId: 1)
        for gameAction in gameActions {
            if gameAction.actionType.name == "Move Unit" {
                game.addCommand(command: MoveCommand(unit: Unit(name: "Settler", maxHP: 10), toPosition: ""))
            }
            else if gameAction.actionType.name == "Research Tech" {
                game.addCommand(command: TechCommand())
            }
            else if gameAction.actionType.name == "Build Building" {
                game.addCommand(command: BuildBuildingCommand())
            }
            else if gameAction.actionType.name == "Build City" {
                game.addCommand(command: BuildCityCommand())
            }
        }
        
        game.processCommands()
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ss.SSS"
        print(string + formatter.string(from: date))
    }
    
    @objc func handleZoom(sender: UIPinchGestureRecognizer) {
        if (sender.state == .changed) {
            var scale = initialCameraScale + (1/sender.scale - 1) * initialCameraScale
            
            if scale >= 4.4 {
                scale = 4.4
            }
            gameCamera.setScale(scale)
        }
    }
    
    private func renderMap(map: Map) {
        var terrainMaps: [SKTileMapNode] = []

        for layer in 0..<map.getNumLayers() {
            let terrainMap = SKTileMapNode(tileSet: tileset,
                                           columns: cols,
                                           rows: rows,
                                           tileSize: tileSize)
            terrainMap.name = "terrain_\(layer)"
            terrainMap.zPosition = Layer.terrain + CGFloat(layer)
            terrainMap.position = CGPoint.zero
            terrainMap.enableAutomapping = true

            terrainMaps.append(terrainMap)
        }
        
        let unitsMap = SKTileMapNode(tileSet: tileset,
                                     columns: cols,
                                     rows: rows,
                                     tileSize: tileSize)
        unitsMap.name = "units"
        unitsMap.zPosition = Layer.units
        unitsMap.position = CGPoint.zero
        unitsMap.enableAutomapping = true
        
        for row in stride(from: map.height, to: -1, by: -1) {
            for col in 0..<map.width {
                for tile in map.getTiles(row: row, col: col) {
                    if let tileType = Constants.tiles[tile.id] {
                        if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileType }) {
                            // Make sure we are setting the tile on the correct layered terrain map
                            let terrainMap = terrainMaps[tile.ordinal]
                            
                            terrainMap.setTileGroup(tileGroup, forColumn: col, row: row)
                        }
                        else {
                            fatalError("No tile group \"\(tileType)\" in tile set \"\(tilesetName)\"")
                        }
                    }
                    else {
                        fatalError("No tile id \"\(tile.id)\" in global lookup.")
                    }
                }
            }
        }
        
        for terrainMap in terrainMaps {
            addChild(terrainMap)
        }
        addChild(unitsMap)
        addChild(pathMap)
        addChild(mapIcons)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func showAIPath(path: [GKGraphNode]) {
        let tileGroupName = "Fog"
        
        for node in path {
            let theNode: GKGridGraphNode = node as! GKGridGraphNode
            
            if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileGroupName }) {
                print("[\(theNode.gridPosition.y),\(theNode.gridPosition.x)]")
                pathMap.setTileGroup(tileGroup,
                                     forColumn: Int(theNode.gridPosition.y),
                                     row: Int(theNode.gridPosition.x))
            }
            else {
                fatalError("\"\(tileGroupName)\" tile group not found in \"\(tilesetName)\" tile set.")
            }
        }
    }
    
    func showRandomAIPaths() {
        //        print("About to calculate \(numPaths) paths: " + formatter.string(from: Date()))
        let numPaths: Int = 1000
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        
        for _ in 0..<numPaths {
            let from = SIMD2<Int32>(Int32.random(in: 0..<Int32(pathMap.numberOfRows)),
                                    Int32.random(in: 0..<Int32(pathMap.numberOfColumns)))
            let to = SIMD2<Int32>(Int32.random(in: 0..<Int32(pathMap.numberOfRows)),
                                  Int32.random(in: 0..<Int32(pathMap.numberOfColumns)))
            let path = game.getMap().findPath(from: from, to: to)
            
            for node in path {
                let theNode: GKGridGraphNode = node as! GKGridGraphNode
                
                if let tileGroup = tileset.tileGroups.first(where: { $0.name == "Fog"}) {
                    pathMap.setTileGroup(tileGroup,
                                         forColumn: Int(theNode.gridPosition.y),
                                         row: Int(theNode.gridPosition.x))
                }
            }
        }
        //        print("Done calculating \(numPaths) paths: " + formatter.string(from: Date()))
    }
}
