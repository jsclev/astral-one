import Foundation

public class CreateCityCommand: Command {
    public private(set) var cityCreator: Builder
    private var cityName: String
    public private(set) var city: City?
    
    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            cost: Int,
                            cityCreator: Builder,
                            cityName: String) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  cost: cost,
                  cityCreator: cityCreator,
                  cityName: cityName)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cost: Int,
                cityCreator: Builder,
                cityName: String) {
        self.cityCreator = cityCreator
        self.cityName = cityName
        
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
        if cityCreator.canCreateCity.value {
            city = City(id: Constants.noId,
                        owner: player,
                        theme: player.game.theme,
                        name: cityName,
                        assetName: "city-1",
                        position: cityCreator.position)
            
            if commandId == Constants.noId {
                do {
                    city = try player.game.db.createCityCommandDao.insert(command: self)
                }
                catch {
                    return CommandResult(status: CommandStatus.Invalid, message: "\(error)")
                }
            }
            
            if let newCity = city {
                player.create(city: newCity, using: cityCreator)
            }
            
            turn.step()
            return CommandResult(status: CommandStatus.Ok, message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid,
                             message: cityCreator.canCreateCity.message)
    }
}
