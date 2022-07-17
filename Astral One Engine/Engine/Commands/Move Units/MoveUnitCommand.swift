import Foundation
import SpriteKit

public class MoveUnitCommand: Command {
    public let unit: Unit
    public let to: Position
    
    public init(player: Player,
                turn: Turn,
                unit: Unit,
                to: Position) {
        self.unit = unit
        self.to = to
        
        super.init(player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 10)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                unit: Unit,
                to: Position) {
        self.unit = unit
        self.to = to
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 10)
    }
    
    public init(db: Db,
                player: Player,
                turn: Turn,
                unit: Unit,
                to: Position) {
        self.unit = unit
        self.to = to
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        if to != unit.position {
            player.deselectUnit()
            
            if persist {
                do {
                    guard let db = database else {
                        return CommandResult(status: CommandStatus.Invalid,
                                             message: "Some type of error occurred")
                    }
                    
                    try db.moveUnitCommandDao.insert(command: self)
                }
                catch {
                    return CommandResult(status: CommandStatus.Invalid,
                                         message: "Some type of error occurred")
                }
            }
            
            unit.move(to: to)
            
            return CommandResult(status: CommandStatus.Ok, message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid, message: "Something went wrong")
        
    }
}
