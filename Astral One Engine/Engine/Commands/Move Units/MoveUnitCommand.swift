import Foundation
import SpriteKit

public class MoveUnitCommand: Command {
    public let unit: Unit
    public let to: Position
    private var currentDisplayText: String
    private var currentDebugText: String
    
    public init(player: Player,
                turn: Turn,
                unit: Unit,
                to: Position) {
        self.unit = unit
        self.to = to
        
        self.currentDisplayText = "Ready to move unit \(unit.name)."
        self.currentDebugText = "Ready to move unit \(unit.name)."
        
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
        
        self.currentDisplayText = "Ready to move unit \(unit.name)."
        self.currentDebugText = "Ready to move unit \(unit.name)."
        
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
        
        self.currentDisplayText = "Ready to move unit \(unit.name)."
        self.currentDebugText = "Ready to move unit \(unit.name)."
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 10)
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
            
            currentDisplayText = "\(player.name) moved unit \(unit.name) to [\(to.row), \(to.col)]."
            currentDebugText = "\(player.name) moved unit \(unit.name) to \(to)."

            return CommandResult(status: CommandStatus.Ok, message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid, message: "Something went wrong")
        
    }
}
