import Foundation
import SpriteKit

public class NextTurnCommand: Command {
    private let game: Game
    
    public init(commandId: Int,
                game: Game,
                turn: Turn,
                player: Player,
                type: CommandType,
                ordinal: Int) {
        self.game = game
        
        super.init(commandId: commandId,
                   gameId: 1,
                   turn: turn,
                   player: player,
                   type: type,
                   ordinal: ordinal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        game.nextTurn()
    }
}
