import SpriteKit
import SwiftUI
import Engine

@main
struct GameApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                GameView()
            }
            .statusBar(hidden: true)
        }
    }
}

class AppConstants {
    static let gameId = 1
    static let themeId = 1
}

struct GameView: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @State private var isAnimating = false
    @State private var dragAnimationCount = 0
    
    @State private var startCameraPosition = CGPoint.zero
    @GestureState private var cameraPosition = CGPoint.zero
    
    @State private var location: CGPoint = .zero
    @GestureState private var fingerLocation: CGPoint? = nil
    
    var mapViewModel = MapViewModel()
    var scene: GameScene
    
    init() {
        scene = GameScene(mapViewModel: mapViewModel)
    }
    
    var simpleDrag: some Gesture {
        DragGesture(minimumDistance: isAnimating ? 5 : 5)
            .onChanged { value in
                
                if !isDragging {
                    isDragging = true
                    startCameraPosition = scene.gameCamera.position
                    scene.gameCamera.removeAction(forKey: "map-pan-momentum")
                }
                
                scene.gameCamera.position = CGPoint(x: startCameraPosition.x - (value.translation.width * mapViewModel.scale),
                                                    y: startCameraPosition.y + (value.translation.height * mapViewModel.scale))
                
                // Get the offset between the start location and the camera's position
                //                print("--------------------------------------------------------------------------")
                //                print("translation: [\(value.translation.width), \(value.translation.height)]")
                //                print("finger location: \(value.location)")
                //                print("start location: \(value.startLocation)")
                //                print("Camera position: \(scene.gameCamera.position)")
            }
            .onEnded { value in
                let temp = (value.predictedEndTranslation.width - value.translation.width)
                let temp2 = (value.predictedEndTranslation.height - value.translation.height)
                let magnitude = sqrt(
                    (temp * temp +
                     temp2 * temp2))
                
                isDragging = false
                
                var duration = (magnitude/2000) + 0.8
                if duration < 0.8 {
                    duration = 0.8
                }
                //                print("magnitude: \(magnitude)")
                //                print("duration: \(duration)")
                
                let moveAction = SKAction.move(to: CGPoint(x: startCameraPosition.x - (value.predictedEndTranslation.width * mapViewModel.scale),
                                                           y: startCameraPosition.y + (value.predictedEndTranslation.height * mapViewModel.scale)),
                                               duration: duration,
                                               delay: 0,
                                               usingSpringWithDamping: 9.5,
                                               initialSpringVelocity: 1.0)
                if (magnitude > 10) {
                    isAnimating = true
                    dragAnimationCount += 1
                    let currentAnimationCount = dragAnimationCount
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        if dragAnimationCount == currentAnimationCount {
                            isAnimating = false
                            dragAnimationCount = 0
                        }
                    }
                } else {
                    isAnimating = false
                }
                
                scene.gameCamera.run(moveAction, withKey: "map-pan-momentum")
            }
    }
    
    var body: some View {
        ZStack {
#if DEBUG
            if #available(iOS 15.0, *) {
                SpriteView(scene: scene, debugOptions: [.showsFPS,
                                                        .showsNodeCount,
                                                        .showsDrawCount])
                .ignoresSafeArea()
                //                    .simultaneousGesture(simpleDrag)
            }
            else {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
                    .gesture(simpleDrag)
            }
#else
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .gesture(simpleDrag)
#endif
        }
    }
}

struct TouchInfo {
    var location: CGPoint
    var time: TimeInterval
}

class GameScene: SKScene {
    var game: Game
    let db: Db
    var eventBus: EventBus?
    var mapViewModel: MapViewModel
    var contextMenu: Engine.ContextMenu!
    var cityCreatorMenu: CityCreatorMenu!
    var gameCamera: Camera!
    var cameraScale = 1.0
    var initialCameraScale = 1.0
    var gameGestureRecognizer: GameGestureRecognizer!
    var tilesetName = Constants.tilesetName
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
    var mapIconsTileset: SKTileSet!
    let tileSize: CGSize = CGSize(width: 96, height: 48)
    var previousCameraPoint = CGPoint.zero
    var startTouchPos = CGPoint.zero
    let tileSet: SKTileSet
    var mapView: MapManager!
    
    private var initialCameraPosition: CGPoint = .zero
    private var previousCameraScale: CGFloat = 1.0
    private var previousTranslation: CGSize = .zero
    private var previousOffset: CGSize = .zero
    private var lastZoomCenterLocation: CGPoint = .zero
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        
        db = Db(fullRefresh: true)
        
        do {
            game = try db.getGameBy(gameId: AppConstants.gameId, themeId: AppConstants.themeId)
        }
        catch {
            print(error)
            fatalError("Could not initialize game object.")
        }
        
        if let ts = SKTileSet(named: Constants.tilesetName) {
            tileSet = ts
        }
        else {
            fatalError("Unable to find \"\(Constants.tilesetName)\" tile set.")
        }
        
        mapIconsTileset = SKTileSet(named: mapIconsTilesetName)
        
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    override func didMove(to view: SKView) {
        do {
            try db.mapDao.importTiledMap(gameId: AppConstants.gameId, filename: Constants.mapFilename)
            game = try db.getGameBy(gameId: AppConstants.gameId, themeId: AppConstants.themeId)
        }
        catch {
            print(error)
        }
        
        game.canvasSize = frame.size
        gameCamera = Camera(game: game, player: game.currentPlayer)
        
        camera = gameCamera
        addChild(gameCamera)
        
        gameCamera.show()
        
        //        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
        //        view.addGestureRecognizer(panGesture)
        
        game.processCommands()
        
        //        for cityId in 0..<1000 {
        //            let position = Position(row: Int.random(in: 0..<game.map.height),
        //                                    col: Int.random(in: 0..<game.map.width))
        //            let settler = Settler(game: game,
        //                                      player: player,
        //                                      theme: game.theme,
        //                                      name: "Settler",
        //                                      position: position)
        //            let city = City(id: cityId + 100,
        //                            owner: player,
        //                            theme: game.theme,
        //                            name: "New York",
        //                            assetName: "city-1",
        //                            position: position)
        //            player.add(cityCreator: settler)
        //
        //            let createInfantry1Action = CreateInfantry1Action(game: game, player: player, city: city)
        //            let createInfantry2Action = CreateInfantry2Action(game: game, player: player, city: city)
        //            let createInfantry3Action = CreateInfantry3Action(game: game, player: player, city: city)
        //            let createInfantry4Action = CreateInfantry4Action(game: game, player: player, city: city)
        //
        //            createInfantry1Action.execute()
        //            createInfantry2Action.execute()
        //            createInfantry3Action.execute()
        //            createInfantry4Action.execute()
        //        }
        
        //        let fowGenerator = FogOfWarGenerator(player: player)
        //        fowGenerator.generate()
        game.currentPlayer.map.revealAllTiles()
        let tileset = SKTileSet(named: Constants.tilesetName)
                
        mapView = MapManager(player: game.currentPlayer, scene: self, tileset: tileset!)
        contextMenu = ContextMenu(game: game, parent: self, mapView: mapView)
        cityCreatorMenu = CityCreatorMenu(player: game.currentPlayer, parent: self, mapManager: mapView)
        
        eventBus = EventBus(game: game, scene: self, mapManager: mapView)
        
        if let eb = eventBus {
            gameGestureRecognizer = GameGestureRecognizer(target: self,
                                                          action: #selector(handleGestures),
                                                          eventBus: eb)
            view.addGestureRecognizer(gameGestureRecognizer)
        }
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ss.SSS"
        print(string + formatter.string(from: date))
    }
    
    @objc func handleGestures(sender: GameGestureRecognizer) {
        switch sender.state {
        case .began:
            gameCamera.removeAction(forKey: "map-pan-momentum")
            gameCamera.removeAction(forKey: "map-scale-momentum")
            
            initialCameraPosition = gameCamera.position
            mapViewModel.scale = gameCamera.xScale
            initialCameraScale = mapViewModel.scale
            previousOffset = .zero
            previousTranslation = .zero
            previousCameraScale = 0
            mapViewModel.zoomBegan()
        case .changed:
            
            
            
            mapViewModel.updateScale(newScale: sender.scale)
            gameCamera.setScale(mapViewModel.scale)
            
            
            let point = sender.location(in: nil)
            
            let fromCenter = CGSize(width: point.x - game.canvasSize.width/2, height: point.y - game.canvasSize.height/2)
            
            
            // let currentTranslation = CGSize(width: sender.translation.width - previousTranslation.width, height: sender.translation.height - previousTranslation.height)
            
            let scaleX = gameCamera.xScale - mapViewModel.initialScale
            let scaleXDifference = scaleX - previousCameraScale
            let offsetX = (fromCenter.width - sender.translation.width) * -scaleXDifference
            
            
            let scaleY = gameCamera.yScale - mapViewModel.initialScale
            let scaleYDifference = scaleY - previousCameraScale
            
            let offsetY = (fromCenter.height - sender.translation.height ) * scaleYDifference
            
            previousOffset.width += offsetX
            previousOffset.height += offsetY
            
            
            gameCamera.position = CGPoint(x: initialCameraPosition.x + previousOffset.width - (sender.translation.width * mapViewModel.scale),
                                          y: initialCameraPosition.y + previousOffset.height + (sender.translation.height * mapViewModel.scale))
            
            if previousCameraScale != scaleX {
                lastZoomCenterLocation = sender.location(in: nil)
            }
            
            previousTranslation = sender.translation
            previousCameraScale = scaleX
        case .ended:
            
            let velocity = sender.predictedExtraTranslation
            
            let magnitude = sqrt(
                (velocity.width * velocity.width +
                 velocity.height * velocity.height))
            
            
            let translationDuration = (magnitude/2000) + 0.8
            
            var velocityScale = gameCamera.xScale / sender.predictedExtraScale
            velocityScale = min(max(velocityScale, Constants.minZoom), Constants.maxZoom)
            
            //            let point = sender.location(in: nil)
            let fromCenter = CGSize(width: lastZoomCenterLocation.x - game.canvasSize.width/2, height: lastZoomCenterLocation.y - game.canvasSize.height/2)
            
            let scaleX = velocityScale - gameCamera.xScale
            let offsetX = fromCenter.width * -scaleX
            
            
            let scaleY = velocityScale - gameCamera.yScale
            let offsetY = fromCenter.height * scaleY
            
            var scaleDuration = sender.predictedExtraScale - 1
            
            if scaleDuration < 0 {
                scaleDuration = abs(1/scaleDuration)
            }
            
            scaleDuration /= 3
            
            var duration = 0.0
            
            if sender.predictedExtraScale == 1 {
                duration = translationDuration
            } else {
                duration = 0.65
            }
            
            let moveAction = SKAction.move(to: CGPoint(
                x: gameCamera.position.x - velocity.width * mapViewModel.scale + offsetX,
                y: gameCamera.position.y + velocity.height * mapViewModel.scale + offsetY
            ),
                                           duration: duration,
                                           delay: 0,
                                           usingSpringWithDamping: 9.5,
                                           initialSpringVelocity: 1.0)
            
            
            let scaleAction = SKAction.scale(to: velocityScale,
                                             duration: duration,
                                             delay: 0,
                                             usingSpringWithDamping: 9.5,
                                             initialSpringVelocity: 1.0)
            
            gameCamera.run(moveAction, withKey: "map-pan-momentum")
            gameCamera.run(scaleAction, withKey: "map-scale-momentum")
            
        default:
            break
        }
    }
}

