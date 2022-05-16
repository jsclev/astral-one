import Foundation

public class BuildBuildingCommand: Command {
    //    private let unit: Unit
    //    private let toPosition: String
    
    public init(commandId: Int,
                game: Game,
                turn: Turn,
                player: Player,
                type: CommandType,
                ordinal: Int,
                unit: Unit,
                toPosition: String) {
//        self.unit = unit
//        self.toPosition = toPosition
        super.init(commandId: commandId,
                   game: game,
                   turn: turn,
                   player: player,
                   type: type,
                   ordinal: ordinal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        print("Executing build building command")
    }
}
