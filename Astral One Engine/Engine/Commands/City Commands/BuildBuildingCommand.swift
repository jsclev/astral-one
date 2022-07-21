import Foundation

public class BuildBuildingCommand: Command {
    public let city: City
    public let buildingType: BuildingType
    private var currentDisplayText: String
    private var currentDebugText: String
    
    public convenience init(player: Player,
                            turn: Turn,
                            city: City,
                            buildingType: BuildingType) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: Constants.noId,
                  city: city,
                  buildingType: buildingType)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                city: City,
                buildingType: BuildingType) {
        self.city = city
        self.buildingType = buildingType
        
        self.currentDisplayText = "Ready to build \(buildingType)."
        self.currentDebugText = "Ready to build \(buildingType)."
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 10.0)
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
        if city.canBuild(building: buildingType) {
            if persist {
                do {
                    guard let db = database else {
                        return CommandResult(status: CommandStatus.Invalid,
                                             message: "Some type of error occurred")
                    }
                    
                    try db.buildBuildingCommandDao.insert(command: self)
                }
                catch {
                    return CommandResult(status: CommandStatus.Invalid, message: "\(error)")
                }
            }
            
            city.build(buildingType)
            
            currentDisplayText = "\(player.name) built \(buildingType) in \(city.name)."
            currentDebugText = "\(player.name) built \(buildingType) in \(city.name)."

            return CommandResult(status: CommandStatus.Ok, message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid,
                             message: "Cannot build \(buildingType) in \(city.name).")
    }
    
}
