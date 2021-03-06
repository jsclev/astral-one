import SpriteKit
import GameplayKit
import Engine

class GameScene: SKScene {
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        let fileManager = FileManager.default
        
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let fileUrl = url.appendingPathComponent("commands.txt")
        print("Writing command data to \(fileUrl.path).")
        
        fileManager.createFile(atPath: fileUrl.path,
                               contents: nil,
                               attributes: [FileAttributeKey.creationDate: Date()])
        
        let gridGraph = GridGraph(width: 0, height: 0)
        // gridGraph.add(node: Node(row: 0, col: 0))
        
//        let db = Db(fullRefresh: true)
//        let game = Game(db: db)
        
        let turn = Turn(id: 1,
                        year: -4000,
                        ordinal: 0,
                        displayText: "4000 BCE")
        let commandType = CommandType(id: 1,
                                      name: "Move Unit")
        
        
        printDate(string: "Starting: ")
        var moveCommands: [MoveUnitCommand] = []
//        let newCommands: [MoveCommand] = []

        //        if let fileHandle = try? FileHandle(forWritingTo: fileUrl) {
        for _ in 0..<1000000 {
            moveCommands.append(MoveUnitCommand(player: player,
                                                type: commandType,
                                                turn: turn,
                                                ordinal: 1,
                                                unit: Infantry1(playerId: 1,
                                                            name: "Warrior",
                                                            row: 0,
                                                            col: 0),
                                            toPosition: "Hello"))
        }
        
//        do {
//            try game.db.commandDao.insertMoveCommands(moveCommands: moveCommands)
//
////            fileHandle.seekToEndOfFile()
////            fileHandle.write((moveCommand.description + "\n").data(using: .utf8)!)
//
////            print("Added move command, id: \(cmd.commandId)")
//        }
//        catch {
//            print("Unexpected error: \(error).")
//        }
//
////        for newCommand in newCommands {
////            print(newCommand)
////        }
//        //            fileHandle.closeFile()
//        printDate(string: "Done: ")
}

func printDate(string: String) {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm:ss.SSS"
    print(string + formatter.string(from: date))
}


func touchDown(atPoint pos : CGPoint) {
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        n.position = pos
        n.strokeColor = SKColor.green
        self.addChild(n)
    }
}

func touchMoved(toPoint pos : CGPoint) {
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        n.position = pos
        n.strokeColor = SKColor.blue
        self.addChild(n)
    }
}

func touchUp(atPoint pos : CGPoint) {
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        n.position = pos
        n.strokeColor = SKColor.red
        self.addChild(n)
    }
}

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let label = self.label {
        label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
    }
    
    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
}

override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
}

override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
}

override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
}


override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
    
    // Initialize _lastUpdateTime if it has not already been
    if (self.lastUpdateTime == 0) {
        self.lastUpdateTime = currentTime
    }
    
    // Calculate time since last update
    let dt = currentTime - self.lastUpdateTime
    
    // Update entities
    for entity in self.entities {
        entity.update(deltaTime: dt)
    }
    
    self.lastUpdateTime = currentTime
}
}
