import Foundation
import Combine
import SpriteKit

public class UnitNode: SKSpriteNode {
    private let game: Game
    private let unit: Unit
    private let mapView: MapView
    
    private var cancellable = Set<AnyCancellable>()
    
    public override var isUserInteractionEnabled: Bool {
        set { }
        get { return true }
    }
    
    public init(game: Game, unit: Unit, mapView: MapView) {
        self.game = game
        self.unit = unit
        self.mapView = mapView
        
        let texture = SKTexture(imageNamed: unit.assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
        
        self.name = "\(unit.name)_"
        
        self.unit.$position
            .dropFirst()
            .sink(receiveValue: { position in
                print("Moved unit [\(position.row),\(position.col)]")
                let point = self.mapView.getCenterPoint(row: position.row,
                                                        col: position.col)
                let moveAction = SKAction.move(to: point,
                                               duration: 0.60)
                self.run(moveAction, completion: {
                    print("Done moving sprite")
                    
                    if let turn = self.game.turns.last {
                        self.game.addCommand(command: NextTurnCommand(commandId: 1,
                                                                      game: self.game,
                                                                      turn: turn,
                                                                      player: Player(playerId: 1),
                                                                      type: CommandType.init(id: 1, name: "NextTurn"),
                                                                      ordinal: 1))
                        self.game.processCommands()
                
                    }
                    
                })
            })
            .store(in: &cancellable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(unit.name), position [\(unit.position.row),\(unit.position.col)]")
        game.selectMapPosition(mapPosition: MapPosition(row: 0, col: 0))
        
        let moveCommand: Command = MoveCommand(commandId: 1,
                                                 gameId: 1,
                                                 turn: Turn(id: 1,
                                                            year: 1900,
                                                            ordinal: 25,
                                                            displayText: "1900"),
                                                 player: Player(playerId: 1),
                                                 type: CommandType.init(id: 1, name: "Move"),
                                                 ordinal: 1,
                                                 unit: unit,
                                                 to: Position(row: unit.position.row - 1,
                                                              col: unit.position.col - 1))
        game.addCommand(command: moveCommand)
        game.processCommands()
    }
}
