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

struct TouchInfo {
    var location: CGPoint
    var time: TimeInterval
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
    var tilesetName: String
    let filename: String = "freeland"
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
    var mapIconsTileset: SKTileSet!
    let tileSize: CGSize = CGSize(width: 96, height: 48)
    var state: PathfinderState = PathfinderState.initialized
    var startPosition = SIMD2<Int32>(0, 0)
    var endPosition = SIMD2<Int32>(0, 0)
    var mapView: MapView
    var previousCameraPoint = CGPoint.zero
    var startTouchPos = CGPoint.zero
    
    init(mapViewModel: MapViewModel) {
        self.db = Db(fullRefresh: true)
        self.game = Game(theme: Theme(id: 1, name: "Standard"))
        self.mapViewModel = mapViewModel
        
        let theme = Theme(id: 2, name: "Sci-Fi")
        self.tilesetName = theme.name + " Tile Set"
        let tileset = SKTileSet(named: tilesetName)

        self.mapView = MapView(game: game, map: game.map, tileset: tileset!)
        mapIconsTileset = SKTileSet(named: mapIconsTilesetName)
        
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    @objc func pan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: sender.view)
        let velocity = sender.velocity(in: sender.view)
        let translation = sender.translation(in: sender.view)
        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
        
        print("Touch location \(location), translation \(translation), velocity \(velocity), magnitude \(magnitude)")


        mapViewModel.moveCamera(translation: CGSize(width: translation.x,
                                                    height: translation.y))
        gameCamera.position = mapViewModel.cameraPosition
        gameCamera.updatePositionLabel(pos: gameCamera.position)
        
        switch sender.state
        {
        case .began:
            startTouchPos = location
            mapViewModel.resetCamera()

        case .changed:
            print("Current camera location \(gameCamera.position)")
            

            
//            gameCamera.position = location
        case .cancelled, .ended, .failed, .possible:
//            print("Last touch location \(location)")
//            print("Pan velocity \(velocity)")
//            print("Current camera location \(gameCamera.position)")
            
            if magnitude > 250 {
                let moveAction = SKAction.move(to: CGPoint(x: gameCamera.position.x - velocity.x / 3,
                                                           y: gameCamera.position.y + velocity.y / 3),
                                               duration: 0.25)
    //            let force = CGVector(dx: velocity.x, dy: velocity.y)
    //            gameCamera.physicsBody?.applyForce(force)
                
    //            let panVelocity = (sender.velocity(in: view))
    //            gameCamera.setCameraPositionVelocity(x: panVelocity.x / 100, y: panVelocity.y / 100)
                
                gameCamera.run(moveAction, completion: {
                    self.mapViewModel.cameraPosition = self.gameCamera.position
                    self.mapViewModel.resetCamera()
                })
            }
            
//            let transformerX = 1024/self.view!.frame.size.with
//            let transformerY = 768/self.view!.frame.size.height
//
//            if (recognizer.state == .ended) {
//                let velocity = recognizer.velocity(InView:self.view)
//                touchedNode.physicsBody?.applyForce:CGVector(dx:velocity.x* transformerX, dy: velocity.y* transformerY)
//            }
//            let push = UIPushBehavior(items: [self.orangeView], mode: .instantaneous)
//            push.pushDirection = CGVector(dx: velocity.x, dy: velocity.y)
//            push.magnitude = magnitude * magnitudeMultiplier
//            dynamicAnimator.removeBehavior(attachment)
//            dynamicAnimator.addBehavior(push)
            mapViewModel.resetCamera()

        default:
            print("Drag")
//            print("Last touch location \(location)")
//            print("Pan velocity \(velocity)")
        }
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
        view.addGestureRecognizer(panGesture)
        
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
        
//        let tileCoordsLayer = TileCoordsMapLayer(game: game,
//                                                 scene: self,
//                                                 mapView: mapView,
//                                                 layerIndex: 10000000)
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
