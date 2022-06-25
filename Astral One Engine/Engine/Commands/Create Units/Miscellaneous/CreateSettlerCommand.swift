import Foundation

public class CreateSettlerCommand: Command {
    public private(set) var settler: Settler?
    public let tile: Tile
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            cost: Int,
                            tile: Tile) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  cost: cost,
                  tile: tile)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cost: Int,
                tile: Tile) {
        self.tile = tile
        
        super.init(commandId: commandId,
                   player: player,
                   type: CommandType(id: Constants.noId, name: ""),
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        settler = Settler(game: player.game,
                          player: player,
                          theme: player.game.theme,
                          name: "Settler-\(Int.random(in: 0..<500))",
                          position: tile.position)
        
        if commandId == Constants.noId {
            do {
                settler = try player.game.db.createUnitCommandDao.insert(command: self)
            }
            catch {
                print(error)
            }
        }
        
        if let newSettler = settler {
            player.add(cityCreator: newSettler)
            
            return CommandResult(status: CommandStatus.Ok, message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid, message: "Some type of error occurred")
    }
    
}
