import Foundation
import SpriteKit

public class NextTurnCommand: Command {
    
    public init(commandId: Int,
                game: Game,
                turn: Turn,
                player: Player,
                type: CommandType,
                ordinal: Int) {
        
        super.init(commandId: commandId,
                   game: game,
                   turn: turn,
                   player: player,
                   type: type,
                   ordinal: ordinal,
                   cost: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        game.nextTurn()
    }
}
