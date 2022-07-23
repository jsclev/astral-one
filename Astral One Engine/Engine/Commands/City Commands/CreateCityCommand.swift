import Foundation

public class CreateCityCommand: Command {
    public private(set) var cityCreator: Builder
    public private(set) var city: City
    private var currentDisplayText: String
    private var currentDebugText: String
    
    public convenience init(player: Player,
                            turn: Turn,
                            cityCreator: Builder) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: Constants.noId,
                  cityCreator: cityCreator)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cityCreator: Builder) {
        self.cityCreator = cityCreator
        
        city = City(id: Constants.noId,
                    owner: player,
                    theme: Theme(id: Constants.noId, name: "Standard"),
                    assetName: "city-1",
                    position: cityCreator.position)
        
        currentDisplayText = "Ready to create city \(city.name)."
        currentDebugText = "Ready to create city \(city.name)."
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 0.0)
    }
    
    public init(db: Db,
                player: Player,
                turn: Turn,
                cityCreator: Builder) {
        self.cityCreator = cityCreator
        
        city = City(id: Constants.noId,
                    owner: player,
                    theme: Theme(id: Constants.noId, name: "Standard"),
                    assetName: "city-1",
                    position: cityCreator.position)
        
        currentDisplayText = "Ready to create city \(city.name)."
        currentDebugText = "Ready to create city \(city.name)."
        
        super.init(db: db,
                   player: player,
                   turn: turn,
                   ordinal: Constants.noId,
                   cost: 0.0)
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
        if cityCreator.canCreateCity.score > 0 {
            if persist {
                do {
                    guard let db = database else {
                        return CommandResult(status: CommandStatus.Invalid,
                                             message: "Some type of error occurred")
                    }
                    
                    city = try db.createCityCommandDao.insert(command: self)
                }
                catch {
                    return CommandResult(status: CommandStatus.Invalid, message: "\(error)")
                }
            }
            
            player.create(city: city, using: cityCreator)
                
            currentDisplayText = "\(cityCreator.name) created city \(city.name)."
            currentDebugText = "\(cityCreator.name) created city \(city.name) \(city.id)."
            
            return CommandResult(status: CommandStatus.Ok, message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid,
                             message: cityCreator.canCreateCity.message)
    }
}
