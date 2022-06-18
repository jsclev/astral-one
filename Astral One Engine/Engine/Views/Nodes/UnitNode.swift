import Foundation
import Combine
import SpriteKit

public class UnitNode: SKSpriteNode {
    private let player: Player
    private let unit: Unit
    private let mapManager: MapManager
    private let prevPosition: Position
    private let selectedNode: SKSpriteNode
    
    private var cancellable = Set<AnyCancellable>()
    
//    public override var isUserInteractionEnabled: Bool {
//        set { }
//        get { return true }
//    }
    
    public init(player: Player, unit: Unit, mapManager: MapManager) {
        self.player = player
        self.unit = unit
        self.mapManager = mapManager
        self.prevPosition = unit.position
        
        let selectedTexture = SKTexture(imageNamed: "select-single")
        selectedNode = SKSpriteNode(texture: selectedTexture,
                                    color: UIColor.systemPink,
                                    size: selectedTexture.size())
        selectedNode.position = mapManager.getCenterPointOf(position: unit.position)
        selectedNode.zPosition = Layer.unitSelection
        selectedNode.name = unit.name + "-selected"
        selectedNode.isHidden = true
        self.mapManager.scene.addChild(selectedNode)
        
        let texture = SKTexture(imageNamed: unit.assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
        
        self.name = "\(unit.name)_"
        
        attachSubscribers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attachSubscribers() {
        self.unit.$position
            .sink(receiveValue: { position in
                if self.prevPosition != position {
                    let point = self.mapManager.getCenterPointOf(position: position)
                    let moveAction = SKAction.move(to: point, duration: 0.60)
                    
                    self.run(moveAction, completion: {
                        if let turn = self.player.game.turns.last {
                            self.player.game.addCommand(command: NextTurnCommand(commandId: 1,
                                                                                 player: Player(playerId: 1,
                                                                                                game: self.player.game,
                                                                                                map: self.player.map),
                                                                                 type: CommandType.init(id: 1,
                                                                                                        name: "NextTurn"),
                                                                                 turn: turn,
                                                                                 ordinal: 1))
                            self.player.game.processCommands()
                            
                        }
                        
                    })
                }
            })
            .store(in: &cancellable)
        
        self.player.$selectedUnit
            .sink(receiveValue: { selectedUnit in
                if let selected = selectedUnit {
                    self.selectedNode.isHidden = !(selected.name == self.unit.name)
                }
            })
            .store(in: &cancellable)
    }
    
    private func toggleSelectedIndicator(value: Bool) {
        print("Unit selected value: \(value)")
        
        if value {
//            selectedNode.isHidden
            mapManager.scene.addChild(selectedNode)
        }
        else {
            selectedNode.removeFromParent()
        }
    }
    
//    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("\(unit.name), position [\(unit.position.row),\(unit.position.col)]")
//        
//        
//    }
}
