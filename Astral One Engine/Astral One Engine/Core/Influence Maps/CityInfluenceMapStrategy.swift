import Foundation

public class CityInfluenceMapStrategy: InfluenceMapStrategy {
    let city: String
    let mapSize: Int
    
    public init(city: String, mapSize: Int) {
        self.city = city
        self.mapSize = mapSize
    }
    
    public func getInfluenceMap() -> [[(Float, InfluenceSpreadStrategy)]] {
        let spreadStrategy: InfluenceSpreadStrategy = CityInfluenceSpreadStrategy(city: city)
        
        return Array(repeating: Array(repeating: (0.0, spreadStrategy), count: mapSize), count: mapSize)
    }
}
