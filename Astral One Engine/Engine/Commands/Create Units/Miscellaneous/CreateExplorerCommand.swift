import Foundation

public class CreateExplorerCommand: Command {
    public private(set) var explorer: Explorer
    public let city: City
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            city: City) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  city: city)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                city: City) {
        self.city = city
        
        explorer = Explorer(player: player,
                            theme: Theme(id: Constants.noId, name: "Standard"),
                            name: "Explorer-\(Int.random(in: 0..<500))",
                            position: city.position)
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: explorer.cost)
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
                
                explorer = try db.createUnitCommandDao.insert(command: self)
            }
            catch {
                print(error)
            }
        }
        
        player.add(unit: explorer)
            
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
