import Foundation

public class ResearchAdvanceCommand: Command {
    public let advanceType: AdvanceType
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            cost: Int,
                            advanceType: AdvanceType) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  cost: cost,
                  advanceType: advanceType)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute(save: Bool) -> CommandResult {
        if save && commandId == Constants.noId {
            do {
                try player.game.db.researchAdvanceCommandDao.insert(command: self)
            }
            catch {
                return CommandResult(status: CommandStatus.Invalid, message: "\(error)")
            }
        }
        
        player.add(advanceName: "\(advanceType)")
        turn.step()
        print("Researched \(advanceType)")
            
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
    
}
