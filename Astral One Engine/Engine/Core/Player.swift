import Foundation

public class Player {
    public let playerId: Int
    public var cityCreators: [CityCreator] = []
    public var units: [Unit] = []
    
    public init(playerId: Int) {
        self.playerId = playerId
    }
    
    public func add(cityCreator: CityCreator) {
        cityCreators.append(cityCreator)
    }
    
    public func addUnit(unit: Unit) {
        units.append(unit)
    }
}
