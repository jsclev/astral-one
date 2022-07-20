import Foundation

public class CreateSettlerCommand: Command {
    public private(set) var settler: Settler
    public let tile: Tile
    
    public init(player: Player,
                turn: Turn,
                tile: Tile) {
        self.tile = tile
        
        settler = Settler(player: player,
                          theme: Theme(id: Constants.noId, name: "Standard"),
                          name: "Settler-\(Int.random(in: 0..<500))",
                          position: tile.position)
        
        super.init(commandId: Constants.noId,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 10)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                settler: Settler,
                tile: Tile) {
        self.settler = settler
        self.tile = tile
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 10)
    }
    
    public init(db: Db,
                player: Player,
                turn: Turn,
                tile: Tile) {
        self.tile = tile
        
        settler = Settler(player: player,
                          theme: Theme(id: Constants.noId, name: "Standard"),
                          name: "Settler-\(Int.random(in: 0..<500))",
                          position: tile.position)
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        if persist {
            do {
                guard let db = database else {
                    return CommandResult(status: CommandStatus.Invalid,
                                         message: "Some type of error occurred")
                }
                
                settler = try db.createUnitCommandDao.insert(command: self)
            }
            catch {
                print(error)
            }
        }
        
        player.add(cityCreator: settler)
            
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
    
}
