import Foundation

public class MoveUnitCommand: Command {
    private let unit: Unit
    private let to: Position
    
    public init(player: Player,
                type: CommandType,
                turn: Turn,
                ordinal: Int,
                unit: Unit,
                to: Position) {
        self.unit = unit
        self.to = to
        
        super.init(commandId: Constants.noId,
                   player: player,
                   type: type,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 10)
    }
    
    public init(commandId: Int,
                player: Player,
                type: CommandType,
                turn: Turn,
                ordinal: Int,
                unit: Unit,
                to: Position) {
        self.unit = unit
        self.to = to
        
        super.init(commandId: commandId,
                   player: player,
                   type: type,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        unit.move(to: to)
        
    }
}
