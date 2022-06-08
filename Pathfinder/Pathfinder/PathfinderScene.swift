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
    var previousCameraPoint = CGPoint.zero
    var startTouchPos = CGPoint.zero
    let tileSet: SKTileSet
    let theme = Theme(id: 2, name: "Sci-Fi")
    var mapView: MapView!
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel

        db = Db(fullRefresh: true)
        game = Game(theme: theme, map: Map(mapId: 1, width: 1, height: 1), db: db)
        tilesetName = theme.name + " Tile Set"
        tileSet = SKTileSet(named: tilesetName)!
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
        
        if let mv = mapView {
            mv.tap(location: location)
        }
        
        let touchedNodes = nodes(at: location)
        
        for touchedNode in touchedNodes {
            print("Touched node: \(touchedNode)")
        }
        
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

    }
    
    override func didMove(to view: SKView) {
        gameCamera = PathfinderCamera(game: game)

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
        }
        catch {
            print(error)
        }
        
//        game.processCommands(commands: game.db.commandDao.getCommands(gameId: 1))
        
//        mapView.renderPlayer()
        
//        let tileCoordsLayer = TileCoordsMapLayer(game: game,
//                                                 scene: self,
//                                                 mapView: mapView,
//                                                 layerIndex: 10000000)
        let _ = TurnView(parent: gameCamera, game: game)
        
        game.processCommands()
        
        let player = game.players[0]
        
        for cityId in 0..<1000 {
            let position = Position(row: Int.random(in: 0..<game.map.height),
                                    col: Int.random(in: 0..<game.map.width))
            
//            if position.row % 2 == 0 {
//                player.map.tile(at: position).set(visibility: Visibility.FullyRevealed)
//            }
            
            let settler = Settler(game: game,
                                      player: player,
                                      theme: game.theme,
                                      name: "Settler",
                                      position: position)
            let city = City(id: cityId + 100,
                            owner: player,
                            theme: game.theme,
                            name: "New York",
                            assetName: "city-1",
                            position: position)
//            city1.build(BuildingType.Barracks)
//            city1.build(BuildingType.CityWalls)
            player.add(cityCreator: settler)
//            player.build(city: city, using: cityBuilder)
            
            let createInfantry1Action = CreateInfantry1Action(game: game, player: player, city: city)
            let createInfantry2Action = CreateInfantry2Action(game: game, player: player, city: city)
            let createInfantry3Action = CreateInfantry3Action(game: game, player: player, city: city)
            let createInfantry4Action = CreateInfantry4Action(game: game, player: player, city: city)
            
            createInfantry1Action.execute()
            createInfantry2Action.execute()
            createInfantry3Action.execute()
            createInfantry4Action.execute()
        }
        
        let fowGenerator = FogOfWarGenerator(player: player)
        fowGenerator.generate()
        
        let tileset = SKTileSet(named: tilesetName)
        
        mapView = MapView(player: player, scene: self, tileset: tileset!)
        mapView.setScene(scene: self)
        
        entityManager = EntityManager(scene: self)
        contextMenu = ContextMenu(game: game, parent: self, mapView: mapView)
        founderContextMenu = FounderContextMenu(game: game, parent: self, mapView: mapView)
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
