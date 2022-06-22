import Foundation
import SpriteKit

public class NextTurnCommand: Command {
    
    public init(commandId: Int,
                player: Player,
                type: CommandType,
                turn: Turn,
                ordinal: Int) {
        
        super.init(commandId: commandId,
                   player: player,
                   type: type,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        player.game.nextTurn()
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
