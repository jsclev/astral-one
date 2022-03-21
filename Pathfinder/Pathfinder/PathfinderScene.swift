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
    private let background: SKSpriteNode
    var mapViewModel: MapViewModel
    var debug = true
    var gameCamera: PathfinderCamera!
    var cameraScale = 1.0
    var entityManager: EntityManager!
    var initialCameraScale = 1.0
    var pinchGestureRecognizer: UIPinchGestureRecognizer!
    let tilesetName: String = "Civ 2 Tile Set"
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
    var map: Map
    var startPosition = SIMD2<Int32>(0, 0)
    var endPosition = SIMD2<Int32>(0, 0)

    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        
        map = Map(width: 0, height: 0)
        
        background = SKSpriteNode(texture: mapViewModel.texture3)
        background.name = "background"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.base
        
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
        self.scaleMode = .fill
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
            print("Clicked start position")
            clearMapIcons()
            state = PathfinderState.settingStartPosition
            return
        }
        else if !touchedNodes.isEmpty && touchedNodes[0].name == "calculate-path" {
            print("Clicked calculate path")
            state = PathfinderState.calculatingPath
            showAiPath()
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
                if let tg = mapIcons.tileGroup(atColumn: col, row: row) {
                    print("Removing existing map icon \(tg.name) at [\(row),\(col)].")
                    mapIcons.setTileGroup(nil, forColumn: col, row: row)
                }
                
                if let tg = pathMap.tileGroup(atColumn: col, row: row) {
                    print("Removing existing map icon \(tg.name) at [\(row),\(col)].")
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
        
        let tilesetParser = TiledTilesetParser("civ2")
        let tileset = tilesetParser.parse()
        
        let mapParser = TiledMapParser(tileset: tileset, filename: "civ2")
        map = mapParser.parse()
        map.bake()
        
        renderMap(map: map)
    }
    
    @objc func handleZoom(sender: UIPinchGestureRecognizer) {
        var anchorPoint: CGPoint = sender.location(in: sender.view)
        anchorPoint = convertPoint(fromView: anchorPoint)
        
        if (sender.state == .began) {
            initialCameraScale = gameCamera.xScale
        }
        else if (sender.state == .changed) {
            let scale = initialCameraScale + (1/sender.scale - 1) * initialCameraScale
            gameCamera.setScale(scale)
        }
        else if (sender.state == .ended) {
            //            print("zoom ended, gameCamera scale is \(self.sca.scale)")
        }
    }
    
    private func renderMap(map: Map) {
        let terrainMap = SKTileMapNode(tileSet: tileset,
                                       columns: cols,
                                       rows: rows,
                                       tileSize: tileSize)
        terrainMap.name = "terrain"
        terrainMap.zPosition = Layer.terrain
        terrainMap.position = CGPoint.zero
        terrainMap.enableAutomapping = true
        
        let unitsMap = SKTileMapNode(tileSet: tileset,
                                     columns: cols,
                                     rows: rows,
                                     tileSize: tileSize)
        unitsMap.name = "units"
        unitsMap.zPosition = Layer.units
        unitsMap.position = CGPoint.zero
        unitsMap.enableAutomapping = true
        
        let grassTiles = tileset.tileGroups.first { $0.name == "Grass"}
        var numTiles: CGSize = CGSize(width: 0.0, height: 0.0)
        
        for (rowIndex, row) in map.tiles.enumerated() {
            numTiles.width = CGFloat(rowIndex)
            
            for (colIndex, tile) in row.enumerated() {
                
                if let tileType = gameTiles[tile.id] {
                    if tileType == "Tank" || tileType == "Plane" || tileType == "Town" {
                        if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileType}) {
                            unitsMap.setTileGroup(tileGroup, forColumn: colIndex, row: rowIndex)
                            terrainMap.setTileGroup(grassTiles, forColumn: colIndex, row: rowIndex)
                        }
                    }
                    else {
                        if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileType}) {
                            terrainMap.setTileGroup(tileGroup, forColumn: colIndex, row: rowIndex)
                            
                        }
                    }
                }
            }
        }
        
        addChild(terrainMap)
        addChild(unitsMap)
        addChild(pathMap)
        addChild(mapIcons)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    func showAiPath() {
        let startNode = map.graph.node(atGridPosition: startPosition)
        let endNode = map.graph.node(atGridPosition: endPosition)

        if let startNode = startNode, let endNode = endNode {
            let path = map.graph.findPath(from: startNode, to: endNode)

            for node in path {
                let theNode: GKGridGraphNode = node as! GKGridGraphNode
                
                if let tileGroup = tileset.tileGroups.first(where: { $0.name == "Fog"}) {
                    pathMap.setTileGroup(tileGroup,
                                         forColumn: Int(theNode.gridPosition.y),
                                         row: Int(theNode.gridPosition.x))
                }
            }
        }
    }
}
