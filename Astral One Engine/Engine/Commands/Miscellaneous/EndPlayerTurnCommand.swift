import Foundation
import SpriteKit

public class EndPlayerTurnCommand: Command {
    private var currentDisplayText: String
    private var currentDebugText: String
    
    public init(player: Player,
                turn: Turn) {
        currentDisplayText = "Ready to end turn \(turn.ordinal) for player \(player.name)."
        currentDebugText = "Ready to end turn \(turn.ordinal) for player \(player.name)."
        
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
        currentDisplayText = "Ready to end turn \(turn.ordinal) for player \(player.name)."
        currentDebugText = "Ready to end turn \(turn.ordinal) for player \(player.name)."
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 0)
    }
    
    public init(db: Db,
                player: Player,
                turn: Turn) {
        currentDisplayText = "Ready to end turn \(turn.ordinal) for player \(player.name)."
        currentDebugText = "Ready to end turn \(turn.ordinal) for player \(player.name)."
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var displayText: String {
        return currentDisplayText
    }
    
    public override var debugText: String {
        return currentDebugText
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
        
        let msg = "Ended turn \(turn.ordinal) for player \(player.name)."
        
        player.endTurn()
        
        currentDisplayText = msg
        currentDebugText = msg
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
