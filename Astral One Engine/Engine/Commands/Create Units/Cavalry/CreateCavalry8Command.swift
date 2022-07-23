import Foundation

public class CreateCavalry8Command: Command {
    public private(set) var cavalry: Cavalry8
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
        
        cavalry = Cavalry8(player: player,
                              theme: Theme(id: Constants.noId, name: "Standard"),
                              name: "Cavalry8-\(Int.random(in: 0..<500))",
                              position: city.position)
        
        currentDisplayText = "Ready to create cavalry unit named \(cavalry.name)."
        currentDebugText = "Ready to create Cavalry8 unit named \(cavalry.name) (\(cavalry.id))."
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: cavalry.cost)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                city: City) {
        self.city = city
        
        cavalry = Cavalry8(player: player,
                              theme: Theme(id: Constants.noId, name: "Standard"),
                              name: "Cavalry8-\(Int.random(in: 0..<500))",
                              position: city.position)
        
        currentDisplayText = "Ready to create infantry unit named \(cavalry.name)."
        currentDebugText = "Ready to create Infantry1 unit named \(cavalry.name) (\(cavalry.id))."
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: cavalry.cost)
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
                
                cavalry = try db.createUnitCommandDao.insert(command: self)
            }
            catch {
                print(error)
            }
        }
        
        player.add(unit: cavalry)
        
        let msg = "\(player.name) created cavalry unit \(cavalry.name)"
        currentDisplayText = "\(msg) in \(city.name)."
        currentDebugText = "\(msg) (\(cavalry.id)) in \(city.name)."
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
