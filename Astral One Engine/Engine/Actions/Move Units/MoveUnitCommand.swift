import Foundation

public class MoveUnitCommand: Command {
    private let unit: Unit
    private let to: Position
    
    public init(commandId: Int,
                game: Game,
                turn: Turn,
                player: Player,
                type: CommandType,
                ordinal: Int,
                unit: Unit,
                to: Position) {
        self.unit = unit
        self.to = to
        
        super.init(commandId: commandId,
                   game: game,
                   turn: turn,
                   player: player,
                   type: type,
                   ordinal: ordinal,
                   cost: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        unit.move(to: to)
        
//        player.addAvailable(command: MoveUnitCommand(commandId: -1,
//                                                     game: game,
//                                                     turn: turn,
//                                                     player: player,
//                                                     type: nil,
//                                                     ordinal: ordinal + 1,
//                                                     unit: unit,
//                                                     to: Position(row: to.row - 1, col: to.col)))
    }
}
