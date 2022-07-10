import Foundation

public class BuildBuildingCommand: Command {
    public let city: City
    public let buildingType: BuildingType
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            cost: Int,
                            city: City,
                            buildingType: BuildingType) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  cost: cost,
                  city: city,
                  buildingType: buildingType)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cost: Int,
                city: City,
                buildingType: BuildingType) {
        self.city = city
        self.buildingType = buildingType
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute(save: Bool) -> CommandResult {
        if city.canBuild(building: buildingType) {
            if commandId == Constants.noId {
                do {
                    try player.game.db.buildBuildingCommandDao.insert(command: self)
                }
                catch {
                    return CommandResult(status: CommandStatus.Invalid,
                                         message: "\(error)")
                }
            }
            
            city.build(buildingType)
            
            return CommandResult(status: CommandStatus.Ok,
                                 message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid,
                             message: "Cannot build \(buildingType) in the city \(city.name).")
    }
    
}
