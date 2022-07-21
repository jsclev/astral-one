import Foundation

public class ResearchAdvanceCommand: Command {
    public let advanceType: AdvanceType
    private var currentDisplayText: String
    private var currentDebugText: String
    
    public init(player: Player,
                turn: Turn,
                advanceType: AdvanceType) {
        self.advanceType = advanceType
        
        currentDisplayText = "\(player.name)Ready to research \(advanceType)."
        currentDebugText = "Ready to research \(advanceType)."
        
        super.init(player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 5.0)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                advanceType: AdvanceType) {
        self.advanceType = advanceType
        
        currentDisplayText = "Ready to research \(advanceType)."
        currentDebugText = "Ready to research \(advanceType)."
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 5.0)
    }
    
    public init(db: Db,
                player: Player,
                turn: Turn,
                advanceType: AdvanceType) {
        self.advanceType = advanceType
        
        currentDisplayText = "Ready to research \(advanceType)."
        currentDebugText = "Ready to research \(advanceType)."
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 5.0)
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
                
                try db.researchAdvanceCommandDao.insert(command: self)
            }
            catch {
                return CommandResult(status: CommandStatus.Invalid, message: "\(error)")
            }
        }
        
        player.add(advanceName: "\(advanceType)")
        
        currentDisplayText = "\(player.name) researched \(advanceType)."
        currentDebugText = "\(player.name) researched \(advanceType)."

        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
    
}
