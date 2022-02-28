import SpriteKit
import AVFoundation

class GameScene: SKScene {
    private var particles: SKEmitterNode?
    private var crocodile: SKSpriteNode!
    private var prize: SKSpriteNode!
    
    private static var backgroundMusicPlayer: AVAudioPlayer!
    
    private var sliceSoundAction: SKAction!
    private var splashSoundAction: SKAction!
    private var nomNomSoundAction: SKAction!
    
    private var isLevelOver = false
    private var didCutVine = false
    
    override func didMove(to view: SKView) {
        setUpPhysics()
        setUpScenery()
        setUpPrize()
        setUpVines()
        setUpCrocodile()
        setUpAudio()
    }
    
    //MARK: - Level setup
    
    private func setUpPhysics() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        physicsWorld.speed = 1.0
    }
    
    private func setUpScenery() {
        let texture = SKTexture(imageNamed: "tyrian-sprites-tiles")
        
        var textureRect=CGRect(x: 0.25,
                               y: 0.25,
                               width: 1.0,
                               height: 1.0)
        
        //    let backgroundTexture = SKTexture(rect: textureRect, in: texture)
        //    let sheet=SpriteSheet(texture: SKTexture(imageNamed: "tyrian-sprites-tiles"), rows: 1, columns: 11, spacing: 1, margin: 1)
        
        let originalTexture = SKTexture(imageNamed: "map1")
        
        let mapSize = originalTexture.size()
        
        let textureRect2 = originalTexture.textureRect()
        
        let rect = CGRect(origin: originalTexture.textureRect().origin,
                          size: CGSize(width: 1.0,
                                       height: 1.0))
        
        let croppedTexture = SKTexture(rect: textureRect,
                                       in: originalTexture)
        
        let background=SKSpriteNode(texture: originalTexture)
        
        //    let background = SKSpriteNode(imageNamed: ImageName.background)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
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
    
    private func setUpPrize() {
        prize = SKSpriteNode(imageNamed: ImageName.prize)
        prize.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
        prize.zPosition = Layer.prize
        prize.physicsBody = SKPhysicsBody(circleOfRadius: prize.size.height / 2)
        prize.physicsBody?.categoryBitMask = PhysicsCategory.prize
        prize.physicsBody?.collisionBitMask = 0
        prize.physicsBody?.density = 0.5
        
        //    addChild(prize)
    }
    
    //MARK: - Vine methods
    
    private func setUpVines() {
        //    // load vine data
        //    let decoder = PropertyListDecoder()
        //    guard
        //      let dataFile = Bundle.main.url(
        //        forResource: GameConfiguration.vineDataFile,
        //        withExtension: nil),
        //      let data = try? Data(contentsOf: dataFile),
        //      let vines = try? decoder.decode([VineData].self, from: data)
        //    else {
        //      return
        //    }
        //
        //    for (i, vineData) in vines.enumerated() {
        //      let anchorPoint = CGPoint(
        //        x: vineData.relAnchorPoint.x * size.width,
        //        y: vineData.relAnchorPoint.y * size.height)
        //      let vine = VineNode(length: vineData.length, anchorPoint: anchorPoint, name: "\(i)")
        //
        //      vine.addToScene(self)
        //
        //      vine.attachToPrize(prize)
        //    }
    }
    
    //MARK: - Croc methods
    
    private func setUpCrocodile() {
        crocodile = SKSpriteNode(imageNamed: ImageName.crocMouthClosed)
        crocodile.position = CGPoint(x: size.width * 0.75, y: size.height * 0.312)
        crocodile.zPosition = Layer.crocodile
        crocodile.physicsBody = SKPhysicsBody(
            texture: SKTexture(imageNamed: ImageName.crocMask),
            size: crocodile.size)
        crocodile.physicsBody?.categoryBitMask = PhysicsCategory.crocodile
        crocodile.physicsBody?.collisionBitMask = 0
        crocodile.physicsBody?.contactTestBitMask = PhysicsCategory.prize
        crocodile.physicsBody?.isDynamic = false
        
        //    addChild(crocodile)
        
        //    animateCrocodile()
    }
    
    private func animateCrocodile() {
        let duration = Double.random(in: 2...4)
        let open = SKAction.setTexture(SKTexture(imageNamed: ImageName.crocMouthOpen))
        let wait = SKAction.wait(forDuration: duration)
        let close = SKAction.setTexture(SKTexture(imageNamed: ImageName.crocMouthClosed))
        let sequence = SKAction.sequence([wait, open, wait, close])
        
        crocodile.run(.repeatForever(sequence))
    }
    
    private func runNomNomAnimation(withDelay delay: TimeInterval) {
        crocodile.removeAllActions()
        
        let closeMouth = SKAction.setTexture(SKTexture(imageNamed: ImageName.crocMouthClosed))
        let wait = SKAction.wait(forDuration: delay)
        let openMouth = SKAction.setTexture(SKTexture(imageNamed: ImageName.crocMouthOpen))
        let sequence = SKAction.sequence([closeMouth, wait, openMouth, wait, closeMouth])
        
        crocodile.run(sequence)
    }
    
    //MARK: - Touch handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didCutVine = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let startPoint = touch.location(in: self)
            let endPoint = touch.previousLocation(in: self)
            
            // check if vine cut
            scene?.physicsWorld.enumerateBodies(
                alongRayStart: startPoint,
                end: endPoint,
                using: { body, _, _, _ in
                    self.checkIfVineCut(withBody: body)
                })
            
            // produce some nice particles
            showMoveParticles(touchPosition: startPoint)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        particles?.removeFromParent()
        particles = nil
    }
    
    private func showMoveParticles(touchPosition: CGPoint) {
        //    if particles == nil {
        //      particles = SKEmitterNode(fileNamed: Scene.particles)
        //      particles!.zPosition = 1
        //      particles!.targetNode = self
        //      addChild(particles!)
        //    }
        //    particles!.position = touchPosition
    }
    
    //MARK: - Game logic
    
    private func checkIfVineCut(withBody body: SKPhysicsBody) {
        if didCutVine && !GameConfiguration.canCutMultipleVinesAtOnce {
            return
        }
        
        let node = body.node!
        
        // if it has a name it must be a vine node
        if let name = node.name {
            // snip the vine
            node.removeFromParent()
            
            // fade out all nodes matching name
            enumerateChildNodes(withName: name, using: { node, _ in
                let fadeAway = SKAction.fadeOut(withDuration: 0.25)
                let removeNode = SKAction.removeFromParent()
                let sequence = SKAction.sequence([fadeAway, removeNode])
                node.run(sequence)
            })
            
            crocodile.removeAllActions()
            crocodile.texture = SKTexture(imageNamed: ImageName.crocMouthOpen)
            animateCrocodile()
            run(sliceSoundAction)
            didCutVine = true
        }
    }
    
    private func switchToNewGame(withTransition transition: SKTransition) {
        let delay = SKAction.wait(forDuration: 1)
        let sceneChange = SKAction.run {
            let scene = GameScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        }
        
        run(.sequence([delay, sceneChange]))
    }
    
    //MARK: - Audio
    
    private func setUpAudio() {
        //    if GameScene.backgroundMusicPlayer == nil {
        //      let backgroundMusicURL = Bundle.main.url(
        //        forResource: SoundFile.backgroundMusic,
        //        withExtension: nil)
        //
        //      do {
        //        let theme = try AVAudioPlayer(contentsOf: backgroundMusicURL!)
        //        GameScene.backgroundMusicPlayer = theme
        //      } catch {
        //        // couldn't load file :[
        //      }
        //
        //      GameScene.backgroundMusicPlayer.numberOfLoops = -1
        //    }
        //
        //    if !GameScene.backgroundMusicPlayer.isPlaying {
        //      GameScene.backgroundMusicPlayer.play()
        //    }
        //
        //    sliceSoundAction = .playSoundFileNamed(
        //      SoundFile.slice,
        //      waitForCompletion: false)
        //    splashSoundAction = .playSoundFileNamed(
        //      SoundFile.splash,
        //      waitForCompletion: false)
        //    nomNomSoundAction = .playSoundFileNamed(
        //      SoundFile.nomNom,
        //      waitForCompletion: false)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    override func update(_ currentTime: TimeInterval) {
        if isLevelOver {
            return
        }
        
        if prize.position.y <= 0 {
            isLevelOver = true
            run(splashSoundAction)
            switchToNewGame(withTransition: .fade(withDuration: 1.0))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if isLevelOver {
            return
        }
        
        if (contact.bodyA.node == crocodile && contact.bodyB.node == prize)
            || (contact.bodyA.node == prize && contact.bodyB.node == crocodile) {
            
            isLevelOver = true
            
            // shrink the pineapple away
            let shrink = SKAction.scale(to: 0, duration: 0.08)
            let removeNode = SKAction.removeFromParent()
            let sequence = SKAction.sequence([shrink, removeNode])
            prize.run(sequence)
            run(nomNomSoundAction)
            runNomNomAnimation(withDelay: 0.15)
            // transition to next level
            switchToNewGame(withTransition: .doorway(withDuration: 1.0))
        }
    }
}
