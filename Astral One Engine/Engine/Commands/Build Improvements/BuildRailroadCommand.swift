import Foundation

public class BuildRailroadCommand: Command {
    public private(set) var builder: Builder
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            cost: Int,
                            builder: Builder) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  cost: cost,
                  builder: builder)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cost: Int,
                builder: Builder) {
        self.builder = builder
        
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
        builder.buildRailroad()
        turn.step()
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
