import Foundation
import SpriteKit

public class NextTurnCommand: Command {
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute(save: Bool) -> CommandResult {
        if commandId == Constants.noId {
            do {
                try player.game.db.nextTurnCommandDao.insert(command: self)
            }
            catch {
                return CommandResult(status: CommandStatus.Invalid, message: "\(error)")
            }
        }
        
        player.game.nextTurn()
        turn.step()
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
