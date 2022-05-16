import Foundation
import SpriteKit

public class MoveCommand: Command {
    public let unit: Unit
    public let to: Position
    
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
                   ordinal: ordinal)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func execute() {
        unit.moveTo(position: to)
    }
}
