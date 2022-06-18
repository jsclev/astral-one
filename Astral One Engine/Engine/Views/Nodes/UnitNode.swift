import Foundation
import Combine
import SpriteKit

public class UnitNode: SKSpriteNode {
    private let player: Player
    private let unit: Unit
    private let mapView: MapManager
    private let prevPosition: Position
    
    private var cancellable = Set<AnyCancellable>()
    
//    public override var isUserInteractionEnabled: Bool {
//        set { }
//        get { return true }
//    }
    
    public init(player: Player, unit: Unit, mapView: MapManager) {
        self.player = player
        self.unit = unit
        self.mapView = mapView
        self.prevPosition = unit.position
        
        let texture = SKTexture(imageNamed: unit.assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
        
        self.name = "\(unit.name)_"
        
        self.unit.$position
            .sink(receiveValue: { position in
                if self.prevPosition != position {
                    let point = self.mapView.getCenterPointOf(position: position)
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("\(unit.name), position [\(unit.position.row),\(unit.position.col)]")
//        
//        
//    }
}
