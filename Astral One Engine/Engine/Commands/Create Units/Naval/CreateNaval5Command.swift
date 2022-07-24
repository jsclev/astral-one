import Foundation

public class CreateNaval5Command: Command {
    public private(set) var naval: Naval5
    public let city: City
    private var currentDisplayText: String
    private var currentDebugText: String
    
    public convenience init(player: Player,
                            turn: Turn,
                            city: City) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: Constants.noId,
                  city: city)
    }
    
    public init(db: Db,
                player: Player,
                turn: Turn,
                city: City) {
        self.city = city
        
        naval = Naval5(player: player,
                       theme: Theme(id: Constants.noId, name: "Standard"),
                       name: "Naval5-\(Int.random(in: 0..<500))",
                       position: city.position)
        
        currentDisplayText = "Ready to create naval unit named \(naval.name)."
        currentDebugText = "Ready to create Naval5 unit named \(naval.name) (\(naval.id))."
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: naval.cost)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                city: City) {
        self.city = city
        
        naval = Naval5(player: player,
                       theme: Theme(id: Constants.noId, name: "Standard"),
                       name: "Naval5-\(Int.random(in: 0..<500))",
                       position: city.position)
        
        currentDisplayText = "Ready to create naval unit named \(naval.name)."
        currentDebugText = "Ready to create Naval5 unit named \(naval.name) (\(naval.id))."
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: naval.cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var displayText: String {
        return currentDisplayText
    }
    
    public override var debugText: String {
        return currentDebugText
    }
    
    public override func execute() -> CommandResult {
        if persist {
            do {
                guard let db = database else {
                    return CommandResult(status: CommandStatus.Invalid,
                                         message: "Some type of error occurred")
                }
                
                naval = try db.createUnitCommandDao.insert(command: self)
            }
            catch {
                print(error)
            }
        }
        
        player.add(unit: naval)
        
        let msg = "\(player.name) created naval unit \(naval.name)"
        currentDisplayText = "\(msg) in \(city.name)."
        currentDebugText = "\(msg) (\(naval.id)) in \(city.name)."
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
