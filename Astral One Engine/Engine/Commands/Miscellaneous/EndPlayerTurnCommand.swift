import Foundation
import SpriteKit

public class EndPlayerTurnCommand: Command {
    public init(player: Player,
                turn: Turn) {
        super.init(commandId: Constants.noId,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 0)
    }
    
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
    
    public init(db: Db,
                player: Player,
                turn: Turn) {
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        if persist {
            do {
                guard let db = database else {
                    return CommandResult(status: CommandStatus.Invalid,
                                         message: "Some type of error occurred")
                }
                
                try db.turnCommandDao.insert(command: self)
            }
            catch {
                return CommandResult(status: CommandStatus.Invalid, message: "\(error)")
            }
        }
        
        player.endTurn()
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
