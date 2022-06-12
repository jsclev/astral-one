import Foundation
import Combine
import SpriteKit

internal class TileMapNode: SKTileMapNode {
    private let player: Player
    
    private var cancellable = Set<AnyCancellable>()
    
    public override var isUserInteractionEnabled: Bool {
        set { }
        get { return true }
    }
    
    public init(player: Player, tileSet: SKTileSet,
                columns: Int,
                rows: Int,
                tileSize: CGSize) {
        self.player = player
        super.init(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
        self.isUserInteractionEnabled = true
        
//        self.unit.$position
//            .dropFirst()
//            .sink(receiveValue: { position in
//                print("Moved unit [\(position.row),\(position.col)]")
//                let point = self.mapView.getCenterPointOf(position: position)
//                let moveAction = SKAction.move(to: point, duration: 0.60)
//
//                self.run(moveAction, completion: {
//                    if let turn = self.player.game.turns.last {
//                        self.player.game.addCommand(command: NextTurnCommand(commandId: 1,
//                                                                             player: Player(playerId: 1,
//                                                                                            game: self.player.game,
//                                                                                            map: self.player.map),
//                                                                             type: CommandType.init(id: 1,
//                                                                                                    name: "NextTurn"),
//                                                                             turn: turn,
//                                                                             ordinal: 1))
//                        self.player.game.processCommands()
//
//                    }
//
//                })
//            })
//            .store(in: &cancellable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("I tapped the map")
    }
}
