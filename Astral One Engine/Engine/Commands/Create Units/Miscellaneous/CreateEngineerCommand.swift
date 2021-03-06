import Foundation

public class CreateEngineerCommand: Command {
    private let city: City
    public private(set) var engineer: Engineer

    public convenience init(player: Player,
                            turn: Turn,
                            city: City) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: Constants.noId,
                  city: city)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                city: City) {
        self.city = city
        
        engineer = Engineer(player: player,
                            theme: Theme(id: Constants.noId, name: "Standard"),
                            name: "Engineer",
                            position: city.position)
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: engineer.cost)
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
                
                engineer = try db.createUnitCommandDao.insert(command: self)
            }
            catch {
                fatalError("\(error)")
            }
        }
        
        player.add(unit: engineer)
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
