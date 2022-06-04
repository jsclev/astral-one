import Foundation

public class BuildCityAction: Action {
    public let cityBuilder: CityBuilder
    
    public init(game: Game, player: Player, cityBuilder: CityBuilder) {
        self.cityBuilder = cityBuilder
        
        super.init(id: -1, name: "Build City Action", game: game, player: player)
        
        cost = 0
        
        self.cityBuilder.$position
            .dropFirst()
            .sink(receiveValue: { newPosition in
                print("Unit moved to \(newPosition).")
            })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        if cityBuilder.canBuildCity() {
            
            // FIXME: Need to add an id implementation
            let city = City(id: -1,
                            owner: player,
                            theme: game.theme,
                            name: "New City",
                            assetName: "city-1",
                            position: cityBuilder.position)
            player.build(city: city, using: cityBuilder)
        }
    }
    
}
