import Foundation

public class ResearchAdvanceCommand: Command {
    public let advanceType: AdvanceType
    
    public init(player: Player,
                            turn: Turn,
                            cost: Int,
                            advanceType: AdvanceType) {
        self.advanceType = advanceType
        
        super.init(player: player,
                  turn: turn,
                  ordinal: Constants.noId,
                  cost: cost)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cost: Int,
                advanceType: AdvanceType) {
        self.advanceType = advanceType
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    public init(db: Db,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cost: Int,
                advanceType: AdvanceType) {
        self.advanceType = advanceType
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
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
                
                try db.researchAdvanceCommandDao.insert(command: self)
            }
            catch {
                return CommandResult(status: CommandStatus.Invalid, message: "\(error)")
            }
        }
        
        player.add(advanceName: "\(advanceType)")
        
        print("Researched \(advanceType)")
            
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
    
}
