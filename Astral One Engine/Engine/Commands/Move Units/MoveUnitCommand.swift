import Foundation
import SpriteKit

public class MoveUnitCommand: Command {
    private let mapManager: MapManager
    private let unit: Unit
    private let to: Position
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            mapManager: MapManager,
                            unit: Unit,
                            to: Position) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  mapManager: mapManager,
                  unit: unit,
                  to: to)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                mapManager: MapManager,
                unit: Unit,
                to: Position) {
        self.mapManager = mapManager
        self.unit = unit
        self.to = to
        
        super.init(commandId: commandId,
                   player: player,
                   type: CommandType(id: 1, name: ""),
                   turn: turn,
                   ordinal: ordinal,
                   cost: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        if to != unit.position {
            player.deselectUnit()
            
            let point = mapManager.getCenterOf(position: to)
            let moveAction = SKAction.move(to: point, duration: 0.60)
            
            if let node = unit.node {
                node.run(moveAction, completion: {
                    self.unit.move(to: self.to)
                    self.player.set(selectedUnit: self.unit)
                })
            }
        }
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
