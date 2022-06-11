import Foundation

public class CreateCityCommand: Command {
    public private(set) var cityCreator: CityCreator
    private var cityName: String
    public private(set) var city: City?
    
    public init(player: Player,
         type: CommandType,
         turn: Turn,
         ordinal: Int,
         cost: Int,
         cityCreator: CityCreator,
         cityName: String) {
        self.cityCreator = cityCreator
        self.cityName = cityName
        
        super.init(player: player,
                   type: type,
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    public init(commandId: Int,
         player: Player,
         type: CommandType,
         turn: Turn,
         ordinal: Int,
         cost: Int,
         cityCreator: CityCreator,
         cityName: String) {
        self.cityCreator = cityCreator
        self.cityName = cityName
        
        super.init(commandId: commandId,
                   player: player,
                   type: type,
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        if cityCreator.canCreateCity() {
            city = City(id: Constants.noId,
                        owner: player,
                        theme: player.game.theme,
                        name: cityName,
                        assetName: "city-1",
                        position: cityCreator.position)
            
            if commandId == Constants.noId {
                do {
                    city = try player.game.db.buildCityCommandDao.insert(command: self)
                }
                catch {
                    print(error)
                }
            }
        
            if let newCity = city {
                player.build(city: newCity, using: cityCreator)
            }
        }
    }
}
