import SpriteKit
import AVFoundation

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
    var entityManager: EntityManager!
    let builder = Builder()
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        
        background = SKSpriteNode(texture: mapViewModel.texture3)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        
        
        
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
        
        gameCamera.position = mapViewModel.cameraPosition

        
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
        
//        builder.walk()
        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
//        view.addGestureRecognizer(recognizer)
    }
    
    func toggleDebug() {
        
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
        addChild(background)
        
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
//        for t in touches {
//            print("touchesBegan location: \(t.location(in: self))")
//            self.touchDown(atPoint: t.location(in: self))
//        }
        var location: CGPoint!
        
        for touch in touches {
            location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "builder" {
                    builder.toggleSelected()
                    print("Builder is selected: \(builder.isSelected())")
                }
            }
        }
        
        if let touchLocation = location {
            if builder.isSelected() {
                print("Moving to position")
                builder.moveToPosition(pos: touchLocation, speed: 1.0)
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
