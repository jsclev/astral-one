import Foundation

public class Player {
    public let playerId: Int
    public var cities: [City] = []
    public var cityCreators: [CityCreator] = []
    public var units: [Unit] = []
    
    public init(playerId: Int) {
        self.playerId = playerId
    }
    
    public func add(city: City) {
        cities.append(city)
    }
    
    public func add(cityCreator: CityCreator) {
        cityCreators.append(cityCreator)
    }
    
    public func add(unit: Unit) {
        units.append(unit)
    }
}
