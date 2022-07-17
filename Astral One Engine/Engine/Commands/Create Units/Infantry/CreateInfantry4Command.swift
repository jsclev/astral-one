import Foundation

public class CreateInfantry4Command: Command {
    public private(set) var infantry4: Infantry4?
    public let city: City
    
    public convenience init(player: Player,
                            turn: Turn,
                            cost: Int,
                            city: City) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: Constants.noId,
                  cost: cost,
                  city: city)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cost: Int,
                city: City) {
        self.city = city
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        infantry4 = Infantry4(player: player,
                              theme: Theme(id: Constants.noId, name: "Standard"),
                              name: "Infantry4-\(Int.random(in: 0..<500))",
                              position: city.position)
        
        if commandId == Constants.noId {
            do {
                guard let db = database else {
                    return CommandResult(status: CommandStatus.Invalid,
                                         message: "Some type of error occurred")
                }
                
                infantry4 = try db.createUnitCommandDao.insert(command: self)
            }
            catch {
                print(error)
            }
        }
        
        if let newUnit = infantry4 {
            player.add(unit: newUnit)
            
            return CommandResult(status: CommandStatus.Ok, message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid, message: "Some type of error occurred")
    }
}
