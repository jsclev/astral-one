import SpriteKit
import AVFoundation
import GameplayKit
import Engine
import SwiftUI

enum PathfinderState {
    case initialized
    case settingStartPosition
    case settingStopPosition
    case calculatingPath
}

class PathfinderScene: SKScene {
    let game: Game
    var mapViewModel: MapViewModel
    var contextMenu: Engine.ContextMenu!
    var founderContextMenu: FounderContextMenu!
    var debug = true
    var gameCamera: PathfinderCamera!
    var cameraScale = 1.0
    var entityManager: EntityManager!
    var initialCameraScale = 1.0
    var pinchGestureRecognizer: UIPinchGestureRecognizer!
    let tilesetName: String = Constants.theme + " Tile Set"
    let filename: String = "freeland"
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
    var mapIconsTileset: SKTileSet!
    var pathMap: SKTileMapNode
    var mapIcons: SKTileMapNode
    let tileSize: CGSize = CGSize(width: 96, height: 48)
    var state: PathfinderState = PathfinderState.initialized
    var startPosition = SIMD2<Int32>(0, 0)
    var endPosition = SIMD2<Int32>(0, 0)
    var mapView: MapView
    
    init(game: Game, mapViewModel: MapViewModel) {
        self.game = game
        self.mapViewModel = mapViewModel
        let tileset = SKTileSet(named: tilesetName)

        self.mapView = MapView(game: game, map: game.getMap(), tileset: tileset!)
        
        pathMap = SKTileMapNode(tileSet: tileset!,
                                columns: game.getMap().width,
                                rows: game.getMap().height,
                                tileSize: tileSize)
        pathMap.name = "terrain"
        pathMap.zPosition = Layer.unitPath
        pathMap.position = CGPoint.zero
        pathMap.enableAutomapping = true
        
        mapIconsTileset = SKTileSet(named: mapIconsTilesetName)
        mapIcons = SKTileMapNode(tileSet: mapIconsTileset,
                                 columns: game.getMap().width,
                                 rows: game.getMap().height,
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
        
//        for touchedNode in touchedNodes {
//            print("Touched node: \(touchedNode.name)")
//        }
        
        if !touchedNodes.isEmpty && touchedNodes[0].name == "set-start-position" {
            clearMapIcons()
            state = PathfinderState.settingStartPosition
            return
        }
        else if !touchedNodes.isEmpty && touchedNodes[0].name == "calculate-path" {
//            state = PathfinderState.calculatingPath
//            let path: [GKGridGraphNode] = [] //game.getMap().findPath(from: startPosition, to: endPosition)
//            showAIPath(path: path)
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
        gameCamera = PathfinderCamera(game: game)
        contextMenu = ContextMenu(game: game, parent: self, mapView: mapView)
        founderContextMenu = FounderContextMenu(game: game, parent: self, mapView: mapView)

        camera = gameCamera
        addChild(gameCamera)
        
        gameCamera.show()
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handleZoom))
        view.addGestureRecognizer(pinchGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        
        var cities: [City] = []
        var units: [Engine.Unit] = []

        do {
            try game.importTiledMap(filename: filename)
            try game.load(gameId: 1)
            
            let tileset = SKTileSet(named: tilesetName)

            mapView = MapView(game: game, map: game.getMap(), tileset: tileset!)
            try mapView.setScene(scene: self)
            
            cities = try game.db.cityDao.getCities(gameId: 1)
            units = try game.db.unitDao.getUnits(gameId: 1)
        }
        catch {
            print(error)
        }
        
        game.processCommands(commands: game.db.commandDao.getCommands(gameId: 1))
        
        let player1 = Player(playerId: 1)

        for city in cities {
            player1.add(city: city)
        }
        
        for unit in units {
            player1.add(unit: unit)
        }
        
        game.addPlayer(player: player1)
        mapView.renderPlayer()
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ss.SSS"
        print(string + formatter.string(from: date))
    }
    
    @objc func handleZoom(sender: UIPinchGestureRecognizer) {
        if (sender.state == .changed) {
            mapViewModel.updateScale(newScale: sender.scale)
            gameCamera.setScale(mapViewModel.scale)
            contextMenu.menu.setScale(mapViewModel.scale)
        }
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
