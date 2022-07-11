import Foundation

import Foundation
import SpriteKit

public class CreateProductionCommand: Command {
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int) {
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute(save: Bool) -> CommandResult {
        turn.step()
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
