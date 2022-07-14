import Foundation
import SpriteKit

public class MoveUnitCommand: Command {
    // private let mapManager: MapManager
    public let unit: Unit
    public let to: Position
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            unit: Unit,
                            to: Position) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  unit: unit,
                  to: to)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                unit: Unit,
                to: Position) {
        self.unit = unit
        self.to = to
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute(save: Bool) -> CommandResult {
        if to != unit.position {
            player.deselectUnit()
            
            //let point = mapManager.getCenterOf(position: to)
            //let moveAction = SKAction.move(to: point, duration: 0.60)
            
            if save && commandId == Constants.noId {
                do {
                    try player.game.db.moveUnitCommandDao.insert(command: self)
                }
                catch {
                    return CommandResult(status: CommandStatus.Invalid,
                                         message: "Some type of error occurred")
                }
            }
            
            unit.move(to: self.to)
            turn.step()
            
            return CommandResult(status: CommandStatus.Ok, message: "Success")

            //player.set(selectedUnit: self.unit)
//            if let node = unit.node {
//                node.run(moveAction, completion: {
//                    self.unit.move(to: self.to)
//                    self.player.set(selectedUnit: self.unit)
//                })
//            }
        }
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
        
    }
}
