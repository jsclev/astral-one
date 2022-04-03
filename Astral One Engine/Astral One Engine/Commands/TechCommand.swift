import Foundation

public class TechCommand: Command {
//    private let unit: Unit
//    private let toPosition: String
    
    public init(commandId: Int,
                gameId: Int,
                turn: Turn,
                playerId: Int,
                type: CommandType,
                ordinal: Int,
                unit: Unit,
                toPosition: String) {
        //        self.unit = unit
        //        self.toPosition = toPosition
        super.init(id: commandId,
                   gameId: gameId,
                   turn: turn,
                   playerId: playerId,
                   type: type,
                   ordinal: ordinal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        print("Executing tech command")
    }
}