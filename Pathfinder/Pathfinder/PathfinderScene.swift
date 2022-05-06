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
    var game: Game
    let db: Db
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
    let tileSize: CGSize = CGSize(width: 96, height: 48)
    var state: PathfinderState = PathfinderState.initialized
    var startPosition = SIMD2<Int32>(0, 0)
    var endPosition = SIMD2<Int32>(0, 0)
    var mapView: MapView
    
    init(mapViewModel: MapViewModel) {
        self.db = Db(fullRefresh: true)
        self.game = Game()
        self.mapViewModel = mapViewModel
        
        let tileset = SKTileSet(named: tilesetName)

        self.mapView = MapView(game: game, map: game.map, tileset: tileset!)
        
        mapIconsTileset = SKTileSet(named: mapIconsTilesetName)
        
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
        let location = convertPoint(fromView: recognizorLocation)
        
        let touchedNodes = nodes(at: location)
        
//        for touchedNode in touchedNodes {
//            print("Touched node: \(touchedNode.name)")
//        }
        
        if !touchedNodes.isEmpty && touchedNodes[0].name == "set-start-position" {
//            clearMapIcons()
            state = PathfinderState.settingStartPosition
            return
        }
        else if !touchedNodes.isEmpty && touchedNodes[0].name == "calculate-path" {
//            state = PathfinderState.calculatingPath
//            let path: [GKGridGraphNode] = [] //game.getMap().findPath(from: startPosition, to: endPosition)
//            showAIPath(path: path)
            return
        }
        
//        let tappedRow = mapIcons.tileRowIndex(fromPosition: location)
//        let tappedCol = mapIcons.tileColumnIndex(fromPosition: location)
//
//        if state == PathfinderState.settingStartPosition {
//            let tileGroup = mapIconsTileset.tileGroups.first { $0.name == "Start Icon" }
//            startPosition.y = Int32(tappedCol)
//            startPosition.x = Int32(tappedRow)
//            mapIcons.setTileGroup(tileGroup, forColumn: tappedCol, row: tappedRow)
//            state = PathfinderState.settingStopPosition
//        }
//        else if state == PathfinderState.settingStopPosition {
//            let tileGroup = mapIconsTileset.tileGroups.first { $0.name == "Stop Icon" }
//            endPosition.y = Int32(tappedCol)
//            endPosition.x = Int32(tappedRow)
//            mapIcons.setTileGroup(tileGroup, forColumn: tappedCol, row: tappedRow)
//            state = PathfinderState.calculatingPath
//        }
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
        
        do {
            try db.mapDao.importTiledMap(filename: filename)
            game = try db.getGameBy(gameId: 1)

            let tileset = SKTileSet(named: tilesetName)
            
            mapView = MapView(game: game, map: game.map, tileset: tileset!)
            try mapView.setScene(scene: self)
        }
        catch {
            print(error)
        }
        
//        game.processCommands(commands: game.db.commandDao.getCommands(gameId: 1))
        
        mapView.renderPlayer()
        
        let tileCoordsLayer = TileCoordsMapLayer(game: game,
                                                 scene: self,
                                                 mapView: mapView,
                                                 layerIndex: 10000000)
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
}
