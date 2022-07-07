import Foundation

public class BuildMarketplaceCommand: Command {
    private let city: City
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            cost: Int,
                            city: City) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
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
                   type: CommandType(id: Constants.noId, name: ""),
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        if city.canBuild(building: BuildingType.Marketplace) {
            city.build(BuildingType.Marketplace)
            print("Built a marketplace in \(city.name)")
            
            return CommandResult(status: CommandStatus.Ok, message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid, message: "Some type of error occurred")
    }
    
}
