import SpriteKit
import AVFoundation
import GameplayKit

class GameScene: SKScene {
    private var particles: SKEmitterNode?
    private var crocodile: SKSpriteNode!
    private var prize: SKSpriteNode!
    
    private static var backgroundMusicPlayer: AVAudioPlayer!
    private let background: SKSpriteNode
    
    private var sliceSoundAction: SKAction!
    private var splashSoundAction: SKAction!
    private var nomNomSoundAction: SKAction!
    
    private var isLevelOver = false
    private var didCutVine = false
    var mapViewModel: MapViewModel
    var mapName = "three"
    var debug = true
    var gameCamera: GameCamera!
    var cameraScale = 1.0
    var entityManager: EntityManager!
    var initialCameraScale = 1.0
    let builder = Builder()
    
    var pinchGestureRecognizer: UIPinchGestureRecognizer!
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        
        background = SKSpriteNode(texture: mapViewModel.texture3)
        background.name = "background"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.base
        
        super.init(size: UIScreen.main.bounds.size)
        self.scaleMode = .fill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        //        if sender.state == .ended {
        //
        //            var touchLocation: CGPoint = sender.location(in: sender.view)
        //            touchLocation = self.convertPoint(fromView: touchLocation)
        //            print(touchLocation)
        //
        //            builder.moveToPosition(pos: touchLocation, speed: 1.0)
        //        }
    }
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        gameCamera = GameCamera(entityManager)
        
        camera = gameCamera
        addChild(gameCamera)
        
//        gameCamera.position = mapViewModel.cameraPosition
        
        
        setUpPhysics()
        setUpScenery()
        //        setUpAudio()
        
        let commandCenter = CommandCenter(imageName: "command-center")
        if let spriteComponent = commandCenter.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: 400,
                                                    y: 300)
        }
        entityManager.add(commandCenter)
        
        let barracks = Barracks(imageName: "barracks")
        if let spriteComponent = barracks.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: 400,
                                                    y: 150)
        }
        entityManager.add(barracks)
        
        gameCamera.show()
        
        builder.position = CGPoint(x: 500, y: 400)
        addChild(builder)
        
//        let zoomInAction = SKAction.scale(to: 3.0, duration: 2.0)
//        gameCamera.run(zoomInAction, completion: {
//            self.cameraScale = 3.0
//        })
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handleZoom))
        view.addGestureRecognizer(pinchGestureRecognizer)
        
        let tilesetParser = TiledTilesetParser()
        let tileset = tilesetParser.parse()
        
        let mapParser = TiledMapParser(tileset: tileset)
        let map = mapParser.parse()
        map.bake()
        
        var tileWidth: CGFloat = 0.0
        var numTiles: CGSize = CGSize(width: 0.0, height: 0.0)
        
        renderRandomMap()
        
        //        print("Tileset: \(tileset.name)")
//        for (rowIndex, row) in map.tiles.enumerated() {
//            numTiles.width = CGFloat(rowIndex)
//
//            for (colIndex, tile) in row.enumerated() {
//                if let imageName = terrainTiles[tile.id] {
//                    let spNode = SKSpriteNode(imageNamed: imageName)
////                    print("[\(spNode.calculateAccumulatedFrame().width), \(spNode.calculateAccumulatedFrame().height)]")
//
//                    tileWidth = spNode.calculateAccumulatedFrame().width
//                    numTiles.height = CGFloat(colIndex)
//
//                    spNode.position = CGPoint(x: tileWidth * CGFloat(colIndex),
//                                              y: 1000.0 - tileWidth * CGFloat(rowIndex))
//                    spNode.name = "terrain_" + tile.id
//                    spNode.anchorPoint = CGPoint(x: 0, y: 0)
//                    spNode.zPosition = Layer.terrain
//                    addChild(spNode)
//                }
//            }
//        }
//
//        let fromPosition = SIMD2<Int32>(0, 0)
//        let fromNode = map.graph.node(atGridPosition: fromPosition)
//
//        let toPosition = SIMD2<Int32>(4, 3)
//        let toNode = map.graph.node(atGridPosition: toPosition)
//
//        if let startNode = fromNode, let endNode = toNode {
//            let path = map.graph.findPath(from: startNode, to: endNode)
//
//            for node in path {
//                let theNode: GKGridGraphNode = node as! GKGridGraphNode
//                print(theNode.gridPosition)
//
//                if let imageName = terrainTiles["31"] {
//                    let spNode = SKSpriteNode(imageNamed: imageName)
//                    tileWidth = spNode.calculateAccumulatedFrame().width
//
//                    spNode.position = CGPoint(x: tileWidth * CGFloat(theNode.gridPosition.y),
//                                              y: 1000.0 - tileWidth * CGFloat(theNode.gridPosition.x))
//                    spNode.name = "ai_path_\(theNode.gridPosition.x)_\(theNode.gridPosition.y)"
//                    spNode.anchorPoint = CGPoint(x: 0, y: 0)
//                    spNode.zPosition = Layer.overlays
//                    addChild(spNode)
//                }
//            }
//        }
        
        let mapSize = CGSize(width: tileWidth * numTiles.width,
                             height: tileWidth * numTiles.height)
        print(mapSize)
        print(gameCamera.position)
        
//        gameCamera.position = CGPoint(x: (mapSize.width / 2.0),
//                                      y: (mapSize.height / 2.0))
        gameCamera.position = CGPoint(x: 1194.662 / 2.0,
                                      y: 1621.327 / 3.0)
        print(gameCamera.position)
    }
    
    @objc func handleZoom(sender: UIPinchGestureRecognizer) {
        var anchorPoint: CGPoint = sender.location(in: sender.view)
        anchorPoint = convertPoint(fromView: anchorPoint)
        
        if (sender.state == .began) {
//            print("zoom started")
            self.initialCameraScale = gameCamera.xScale
        }
        else if (sender.state == .changed) {
//            print("zooming...scale is \(sender.scale)")
//            var anchorPointInMySkNode: CGPoint = convertPoint(fromView: anchorPoint)

            var scale = initialCameraScale + (1/sender.scale - 1) * initialCameraScale
            if scale < 0.4 {
                scale = 0.4
            }
            gameCamera.setScale(scale)
            print(gameCamera.xScale)
//            sender.scale = 1.0
            //
            //            [_mySkNode setScale:(_mySkNode.xScale * recognizer.scale)];
            //
            //            CGPoint mySkNodeAnchorPointInScene = [self convertPoint:anchorPointInMySkNode fromNode:_mySkNode];
            //            CGPoint translationOfAnchorInScene = CGPointSubtract(anchorPoint, mySkNodeAnchorPointInScene);
            //
            //            _mySkNode.position = CGPointAdd(_mySkNode.position, translationOfAnchorInScene);
            //
            //            recognizer.scale = 1.0;
        }
        else if (sender.state == .ended) {
//            print("zoom ended, gameCamera scale is \(self.sca.scale)")
        }
    }
    
    func toggleDebug() {
        
    }
    
    private func renderRandomMap() {
        var tileWidth: CGFloat = 0.0
        
//        for row in 0...211 {
//            for col in 0...359 {
//                var randomInt = Int.random(in: 0..<terrainTiles.count)
//
//                while (randomInt >= 20 && randomInt <= 23) ||
//                        (randomInt >= 28 && randomInt <= 31) {
//                    randomInt = Int.random(in: 0..<terrainTiles.count)
//                }
//
//                if let imageName = terrainTiles[String(randomInt)] {
//                    let tileName = "terrain_\(row)_\(col)"
//                    let spNode = SKSpriteNode(imageNamed: imageName)
//                    // print("[\(spNode.calculateAccumulatedFrame().width), \(spNode.calculateAccumulatedFrame().height)]")
//
//                    tileWidth = spNode.calculateAccumulatedFrame().width
//
//                    spNode.position = CGPoint(x: tileWidth * CGFloat(col),
//                                              y: 1000.0 - tileWidth * CGFloat(row))
//                    spNode.name = tileName
//                    spNode.anchorPoint = CGPoint(x: 0, y: 0)
//                    spNode.zPosition = Layer.terrain
//                    addChild(spNode)
//                    print("Added tile \(tileName)")
//                }
//            }
//        }
        
        guard let tileSet = SKTileSet(named: "Civ 2 Tile Set") else {
            fatalError("Tile Set not found")
        }

        let tileSize = CGSize(width: 96, height: 48)
        let rows = 100
        let cols = 100

        let baseMap = SKTileMapNode(tileSet: tileSet,
                                columns: cols,
                                rows: rows,
                                tileSize: tileSize)
        baseMap.zPosition = Layer.terrain
        baseMap.position = CGPoint.zero
        baseMap.enableAutomapping = true
        
        let unitsMap = SKTileMapNode(tileSet: tileSet,
                                    columns: cols,
                                    rows: rows,
                                    tileSize: tileSize)
        unitsMap.zPosition = Layer.foreground
        unitsMap.position = CGPoint.zero
        unitsMap.enableAutomapping = true

//        for col in 0..<cols {
//            for row in 0..<rows {
//                let val = noiseMap.value(at: vector2(Int32(row),Int32(col)))
//                //We will then decide what tiles correspond to what value
//                switch val {
//                case -1.0..<(-0.5):
//                    if let g = tileSet.tileGroups.first(where: {
//                        ($0.name ?? "") == "Water"}) {
//                        map.setTileGroup(g, forColumn: col, row: row)
//                    }
//                default:
//                    if let g = tileSet.tileGroups.first(where: {
//                        ($0.name ?? "") == "Grass"}) {
//                        map.setTileGroup(g, forColumn: col, row: row)
//                    }
//                }
//            }
//        }
        
        let tileGroups = tileSet.tileGroups
        
//        guard let grassTile = tileGroups.first(where: {$0.name == "Grass"}) else {
//            fatalError("No Grass tile definition found")
//        }
        
        let grassTiles = tileSet.tileGroups.first { $0.name == "Grass"}
        let sandTiles = tileSet.tileGroups.first { $0.name == "Sand"}
        let tundraTiles = tileSet.tileGroups.first { $0.name == "Tundra"}
        let waterTiles = tileSet.tileGroups.first { $0.name == "Water"}
        let townTiles = tileSet.tileGroups.first { $0.name == "Town"}
        let planeTiles = tileSet.tileGroups.first { $0.name == "Plane"}
        let tankTiles = tileSet.tileGroups.first { $0.name == "Tank"}
        let fogTiles = tileSet.tileGroups.first { $0.name == "Fog"}
        let jungleTiles = tileSet.tileGroups.first { $0.name == "Jungle"}
        let swampTiles = tileSet.tileGroups.first { $0.name == "Swamp"}
        let snowTiles = tileSet.tileGroups.first { $0.name == "Snow"}
        let plainsTiles = tileSet.tileGroups.first { $0.name == "Plains"}
        
//        map.fill(with: grassTiles)

        for row in 0..<rows {
            for col in 0..<cols {
                let randomInt = Int.random(in: 0..<100)
                if randomInt >= 0 && randomInt < 20 {
                    baseMap.setTileGroup(grassTiles, forColumn: col, row: row)
                }
                else if randomInt >= 20 && randomInt < 40 {
                    baseMap.setTileGroup(plainsTiles, forColumn: col, row: row)
                }
                else if randomInt >= 40 && randomInt < 50 {
                    baseMap.setTileGroup(sandTiles, forColumn: col, row: row)
                }
                else if randomInt >= 50 && randomInt < 60 {
                    baseMap.setTileGroup(swampTiles, forColumn: col, row: row)
                }
                else if randomInt >= 60 && randomInt < 70 {
                    baseMap.setTileGroup(waterTiles, forColumn: col, row: row)
                }
                else if randomInt >= 70 && randomInt < 90 {
                    baseMap.setTileGroup(jungleTiles, forColumn: col, row: row)
                }
                else if randomInt >= 90 && randomInt < 100 {
                    baseMap.setTileGroup(snowTiles, forColumn: col, row: row)
                }
                else if randomInt >= 101 && randomInt < 100 {
                    baseMap.setTileGroup(fogTiles, forColumn: col, row: row)
                }
            }
        }
        
        for row in 0..<rows {
            for col in 0..<cols {
                let randomInt = Int.random(in: 0..<100)
                if randomInt >= 0 && randomInt < 10 {
                    unitsMap.setTileGroup(tankTiles, forColumn: col, row: row)
                }
                else if randomInt >= 20 && randomInt < 30 {
                    unitsMap.setTileGroup(planeTiles, forColumn: col, row: row)
                }
                else if randomInt >= 30 && randomInt < 40 {
                    unitsMap.setTileGroup(townTiles, forColumn: col, row: row)
                }
            }
        }
        
        unitsMap.alpha = 1.0
        addChild(baseMap)
        addChild(unitsMap)
    }
    
    private func setUpPhysics() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        physicsWorld.speed = 1.0
    }
    
    private func setUpScenery() {
        self.anchorPoint = CGPoint.zero
        //    background.zPosition = Layer.background
        //    background.size = CGSize(width: size.width, height: size.height)
//        addChild(background)
        
        let water = SKSpriteNode(imageNamed: ImageName.water)
        //    water.anchorPoint = CGPoint(x: 0, y: 0)
        water.position = CGPoint(x: 0, y: 0)
        water.zPosition = Layer.foreground
        water.size = CGSize(width: size.width, height: size.height * 0.2139)
        //    addChild(water)
    }
    
    func toggleTexture() {
        if (mapName == "zero") {
            mapName = "one"
        }
        else if (mapName == "one") {
            mapName = "two"
        }
        else if (mapName == "two") {
            mapName = "three"
        }
        else {
            mapName = "zero"
        }
        
        if mapName == "zero" {
            let action = SKAction.setTexture(mapViewModel.texture0, resize: false)
            background.run(action)
        }
        if mapName == "one" {
            let action = SKAction.setTexture(mapViewModel.texture1, resize: false)
            background.run(action)
        }
        else if mapName == "two" {
            let action = SKAction.setTexture(mapViewModel.texture2, resize: false)
            background.run(action)
        }
        else if mapName == "three" {
            let action = SKAction.setTexture(mapViewModel.texture3, resize: false)
            background.run(action)
        }
        
        mapViewModel.changeMap(mapName: mapName)
        gameCamera.position = mapViewModel.cameraPosition
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var location: CGPoint!
        var shouldMoveBuilder = true
        
        for touch in touches {
            location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            
            for node in touchedNode {
                if node.name == "builder" {
                    if !builder.isSelected() {
                        shouldMoveBuilder = false
                    }
                    builder.toggleSelected()
//                    print("Builder is selected: \(builder.isSelected())")
                }
                else {
                    if let nodeName = node.name {
                        print(nodeName)
                    }
                    else {
                        print("Node with no name")
                    }
                    
                    if shouldMoveBuilder && builder.isSelected() {
                        builder.moveToPosition(pos: location, speed: 1.0)
                    }
                }
            }
        }
    }
    
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for touch in touches {
    //            let startPoint = touch.location(in: self)
    //            let endPoint = touch.previousLocation(in: self)
    //            print("touchesMoved startPoint: \(startPoint)")
    //            print("touchesMoved endPoint: \(endPoint)")
    //
    //            // check if vine cut
    ////            scene?.physicsWorld.enumerateBodies(
    ////                alongRayStart: startPoint,
    ////                end: endPoint,
    ////                using: { body, _, _, _ in
    ////                    //self.checkIfVineCut(withBody: body)
    ////                })
    ////
    ////            // produce some nice particles
    ////            showMoveParticles(touchPosition: startPoint)
    //        }
    //    }
    
    //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for t in touches {
    //            print("touchesEnded location: \(t.location(in: self))")
    //            self.touchDown(atPoint: t.location(in: self))
    //        }
    //    }
    
    private func switchToNewGame(withTransition transition: SKTransition) {
        
    }
    
    private func setUpAudio() {
        if GameScene.backgroundMusicPlayer == nil {
            let backgroundMusicURL = Bundle.main.url(
                forResource: SoundFile.backgroundMusic,
                withExtension: nil)
            
            do {
                let theme = try AVAudioPlayer(contentsOf: backgroundMusicURL!)
                GameScene.backgroundMusicPlayer = theme
            } catch {
                // couldn't load file :[
            }
            
            GameScene.backgroundMusicPlayer.numberOfLoops = -1
        }
        
        if !GameScene.backgroundMusicPlayer.isPlaying {
            GameScene.backgroundMusicPlayer.play()
        }
        
        sliceSoundAction = .playSoundFileNamed(
            SoundFile.slice,
            waitForCompletion: false)
        splashSoundAction = .playSoundFileNamed(
            SoundFile.splash,
            waitForCompletion: false)
        nomNomSoundAction = .playSoundFileNamed(
            SoundFile.nomNom,
            waitForCompletion: false)
    }
    //
    //    func handlePinch(sender: UIPinchGestureRecognizer) {
    //        if sender.numberOfTouches == 2 {
    //            let locationInView = sender.location(in: self.view)
    //            let location = self.convertPoint(fromView: locationInView)
    //            if sender.state == .changed {
    //                let deltaScale = (sender.scale - 1.0)*2
    //                let convertedScale = sender.scale - deltaScale
    //                let newScale = gameCamera.xScale*convertedScale
    //                gameCamera.setScale(newScale)
    //
    //                let locationAfterScale = self.convertPoint(fromView: locationInView)
    //                let locationDelta = pointSubtract(location, pointB: locationAfterScale)
    //                let newPoint = pointAdd(gameCamera.position, pointB: locationDelta)
    //                gameCamera.position = newPoint
    //                sender.scale = 1.0
    //            }
    //        }
    //    }
    func showAiPath() {
        
    }
}

extension GameScene: SKPhysicsContactDelegate {
    override func update(_ currentTime: TimeInterval) {
        if isLevelOver {
            return
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
