import Foundation
import SpriteKit

public class SelectUnitCommand: Command {
    private let node: SKNode
    private let mapManager: MapManager
    private let unit: Unit
    private let selectSound = SKAction.playSoundFileNamed("tap", waitForCompletion: false)
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            node: SKNode,
                            mapManager: MapManager,
                            unit: Unit) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  node: node,
                  mapManager: mapManager,
                  unit: unit)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                node: SKNode,
                mapManager: MapManager,
                unit: Unit) {
        self.node = node
        self.mapManager = mapManager
        self.unit = unit
        
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
        if let selectedUnit = player.selectedUnit {
            if selectedUnit.position == unit.position {
                player.deselectUnit()
            }
            else {
                player.set(selectedUnit: unit)
            }
        }
        else {
            player.set(selectedUnit: unit)
        }
        
        node.run(selectSound)
        turn.step()
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
