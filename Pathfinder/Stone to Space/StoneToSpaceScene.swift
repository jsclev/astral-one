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
    var founderContextMenu: FounderContextMenu!
    var gameCamera: StoneToSpaceCamera!
    var cameraScale = 1.0
    var initialCameraScale = 1.0
    var pinchGestureRecognizer: UIPinchGestureRecognizer!
    var tilesetName: String
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
    var mapIconsTileset: SKTileSet!
    let tileSize: CGSize = CGSize(width: 96, height: 48)
    var previousCameraPoint = CGPoint.zero
    var startTouchPos = CGPoint.zero
    let tileSet: SKTileSet
    let theme = Theme(id: 2, name: Constants.themeName)
    var mapView: MapManager!
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        
        db = Db(fullRefresh: true)
        game = Game(theme: theme, map: Map(mapId: 1, width: 1, height: 1), db: db)
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
    
    @objc func pan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: sender.view)
        let velocity = sender.velocity(in: sender.view)
        let translation = sender.translation(in: sender.view)
        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
        
        mapViewModel.moveCamera(translation: CGSize(width: translation.x,
                                                    height: translation.y))
        gameCamera.position = mapViewModel.cameraPosition
        gameCamera.updatePositionLabel(pos: gameCamera.position)
        
        switch sender.state
        {
        case .began:
            startTouchPos = location
            mapViewModel.resetCamera()
//        case .changed:
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
            break
        }
    }
    
    @objc func tap(recognizer: UITapGestureRecognizer){
        if let bus = eventBus {
            bus.tap(recognizer: recognizer)
        }
    }
    
    override func didMove(to view: SKView) {
        gameCamera = StoneToSpaceCamera(game: game)

        camera = gameCamera
        addChild(gameCamera)
        
        gameCamera.show()
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handleZoom))
        view.addGestureRecognizer(pinchGestureRecognizer)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
        view.addGestureRecognizer(panGesture)
        
        do {
            try db.mapDao.importTiledMap(filename: Constants.mapFilename)
            game = try db.getGameBy(gameId: 1)
        }
        catch {
            print(error)
        }
        
        let _ = TurnView(parent: gameCamera, game: game)
        
        game.processCommands()
        
        let player = game.getCurrentPlayer()
        
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
        player.map.revealAllTiles()
        let tileset = SKTileSet(named: tilesetName)
        
        // addInitialSettler(player: player)
        
        mapView = MapManager(player: player, scene: self, tileset: tileset!)
        
        contextMenu = ContextMenu(game: game, parent: self, mapView: mapView)
        founderContextMenu = FounderContextMenu(game: game, parent: self, mapView: mapView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        self.eventBus = EventBus(game: game, scene: self, mapManager: mapView)

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
    
    @objc func handleZoom(sender: UIPinchGestureRecognizer) {
        if (sender.state == .changed) {
            mapViewModel.updateScale(newScale: sender.scale)
            gameCamera.setScale(mapViewModel.scale)
            contextMenu.menu.setScale(mapViewModel.scale)
        }
    }
}
