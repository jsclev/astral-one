import Foundation

public class CreateInfantry1Command: Command {
    public private(set) var infantry1: Infantry1
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
        
        infantry1 = Infantry1(player: player,
                              theme: Theme(id: Constants.noId, name: "Standard"),
                              name: "Infantry1-\(Int.random(in: 0..<500))",
                              position: city.position)
        
        currentDisplayText = "Ready to create infantry unit named \(infantry1.name)."
        currentDebugText = "Ready to create Infantry1 unit named \(infantry1.name) (\(infantry1.id))."
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: infantry1.cost)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                city: City) {
        self.city = city
        
        infantry1 = Infantry1(player: player,
                              theme: Theme(id: Constants.noId, name: "Standard"),
                              name: "Infantry1-\(Int.random(in: 0..<500))",
                              position: city.position)
        
        currentDisplayText = "Ready to create infantry unit named \(infantry1.name)."
        currentDebugText = "Ready to create Infantry1 unit named \(infantry1.name) (\(infantry1.id))."
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: infantry1.cost)
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
                
                infantry1 = try db.createUnitCommandDao.insert(command: self)
            }
            catch {
                print(error)
            }
        }
        
        player.add(unit: infantry1)
        
        let msg = "\(player.name) created infantry unit \(infantry1.name)"
        currentDisplayText = "\(msg) in \(city.name)."
        currentDebugText = "\(msg) (\(infantry1.id)) in \(city.name)."
            
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
