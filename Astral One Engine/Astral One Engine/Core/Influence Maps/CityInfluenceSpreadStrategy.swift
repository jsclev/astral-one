import Foundation

public class CityInfluenceSpreadStrategy: InfluenceSpreadStrategy {
    let city: String
    
    public init(city: String) {
        self.city = city
    }
    
    public func getInfluence(row: Int, col: Int) -> Float {
        return 1.0
    }
}
