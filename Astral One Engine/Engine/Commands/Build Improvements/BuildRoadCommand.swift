import Foundation

public class BuildRoadCommand: Command {
    public private(set) var builder: Builder
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            builder: Builder) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  builder: builder)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                builder: Builder) {
        self.builder = builder
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 5.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        builder.buildRoad()
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
