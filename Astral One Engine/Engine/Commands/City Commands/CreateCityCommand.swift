import Foundation

public class CreateCityCommand: Command {
    public private(set) var cityCreator: Builder
    private var cityName: String
    public private(set) var city: City?
    private var currentDisplayText: String
    private var currentDebugText: String
    
    public convenience init(player: Player,
                            turn: Turn,
                            cityCreator: Builder,
                            cityName: String) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: Constants.noId,
                  cityCreator: cityCreator,
                  cityName: cityName)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cityCreator: Builder,
                cityName: String) {
        self.cityCreator = cityCreator
        self.cityName = cityName
        
        currentDisplayText = "Ready to create city \(cityName)."
        currentDebugText = "Ready to create city \(cityName)."
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 0.0)
    }
    
    public init(db: Db,
                player: Player,
                turn: Turn,
                cityCreator: Builder,
                cityName: String) {
        self.cityCreator = cityCreator
        self.cityName = cityName
        
        currentDisplayText = "Ready to create city \(cityName)."
        currentDebugText = "Ready to create city \(cityName)."
        
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
            city = City(id: Constants.noId,
                        owner: player,
                        theme: Theme(id: Constants.noId, name: "Standard"),
                        name: cityName,
                        assetName: "city-1",
                        position: cityCreator.position)
            
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
            
            if let newCity = city {
                player.create(city: newCity, using: cityCreator)
                
                currentDisplayText = "\(cityCreator.name) created city \(newCity.name)."
                currentDebugText = "\(cityCreator.name) created city \(newCity.name) \(newCity.id)."
            
                return CommandResult(status: CommandStatus.Ok, message: "Success")
            }
        }
        
        return CommandResult(status: CommandStatus.Invalid,
                             message: cityCreator.canCreateCity.message)
    }
}
