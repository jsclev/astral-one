import SpriteKit
import AVFoundation
import GameplayKit
import Engine
import SwiftUI

struct TouchInfo {
    var location: CGPoint
    var time: TimeInterval
}

class StoneToSpaceScene: SKScene {
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
    var tilesetName: String
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
    var mapIconsTileset: SKTileSet!
    let tileSize: CGSize = CGSize(width: 96, height: 48)
    var previousCameraPoint = CGPoint.zero
    var startTouchPos = CGPoint.zero
    let tileSet: SKTileSet
    let theme = Theme(id: 2, name: "Sci-Fi")
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
            game = try db.getGameBy(gameId: 1)
        }
        catch {
            fatalError("Unable to initialize game object")
        }
        tilesetName = theme.name + " Tile Set"
        
        if let ts = SKTileSet(named: tilesetName) {
            tileSet = ts
        }
        else {
            fatalError("Unable to find \"\(tilesetName)\" tile set.")
        }
        
        mapIconsTileset = SKTileSet(named: mapIconsTilesetName)
        
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    @objc func tap(recognizer: UITapGestureRecognizer){
        if let bus = eventBus {
            bus.tap(recognizer: recognizer)
        }
    }
    
    override func didMove(to view: SKView) {
        do {
            try db.mapDao.importTiledMap(filename: Constants.mapFilename)
            game = try db.getGameBy(gameId: 1)
        }
        catch {
            print(error)
        }
        
        game.canvasSize = frame.size
        gameCamera = Camera(game: game, player: game.currentPlayer)

        camera = gameCamera
        addChild(gameCamera)
        
        gameCamera.show()
        
        gameGestureRecognizer = GameGestureRecognizer(target: self, action: #selector(handleGestures))
        view.addGestureRecognizer(gameGestureRecognizer)

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
        let tileset = SKTileSet(named: tilesetName)
        
        // addInitialSettler(player: player)
        
        mapView = MapManager(player: game.currentPlayer, scene: self, tileset: tileset!)
        contextMenu = ContextMenu(game: game, parent: self, mapView: mapView)
        cityCreatorMenu = CityCreatorMenu(player: game.currentPlayer, parent: self, mapManager: mapView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        eventBus = EventBus(game: game, scene: self, mapManager: mapView)
    }
    
    private func addInitialSettler(player: Player) {
        let minRow = 2
        let maxRow = player.map.height - 2
        let minCol = 2
        let maxCol = player.map.width - 2
        
        var foundTile = false
        var tile = player.map.tile(at: Position(row: 0, col: 0))
        
        while !foundTile {
            let randomRow = Int.random(in: minRow...maxRow)
            let randomCol = Int.random(in: minCol...maxCol)
            
            tile = player.map.tile(at: Position(row: randomRow, col: randomCol))
            
            if tile.canCreateCity {
                foundTile = true
                print("Adding Settler to [\(randomRow), \(randomCol)]")
            }
        }
        
//        let settler1 = Settler(game: game,
//                              player: player,
//                              theme: game.theme,
//                              name: "Settler",
//                              position: tile.position)
//        let settler2 = Settler(game: game,
//                               player: player,
//                               theme: game.theme,
//                               name: "Settler2",
//                               position: tile.position)
        
//        player.add(cityCreator: settler1)
//        player.add(cityCreator: settler2)
        
//        let createCityCmd = CreateCityCommand(player: player,
//                                              type: CommandType(id: 1, name: ""),
//                                              turn: player.game.getCurrentTurn(),
//                                              ordinal: 1,
//                                              cost: 0,
//                                              cityCreator: settler1,
//                                              cityName: "New York")
        // createCityCmd.execute()
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
            
            
            let currentTranslation = CGSize(width: sender.translation.width - previousTranslation.width, height: sender.translation.height - previousTranslation.height)
            
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
            
            
            var translationDuration = (magnitude/2000) + 0.8
            
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
