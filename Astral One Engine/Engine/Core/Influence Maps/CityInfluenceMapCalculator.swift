import Foundation

public class CityInfluenceMapCalculator: InfluenceMapCalculator {
    let map: Map
    let city: City
    let unit: Unit

    public init(map: Map, city: City, unit: Unit) {
        self.map = map
        self.city = city
        self.unit = unit
    }
    
    public func getInfluenceMap() -> [[Double]] {
        var im: [[Double]] = Array(repeating: Array(repeating: 0.0, count: map.width), count: map.height)
        let diplomacy = city.getDiplomacyStatus(unit: unit)
        
        let startRow = city.row - 1 >= 0 ? city.row - 1 : 0
        let endRow = (city.row + 1 <= map.height - 1 ? city.row + 1 : map.height - 1) + 1
        let startCol = city.col - 1 >= 0 ? city.col - 1 : 0
        let endCol = (city.col + 1 <= map.width - 1 ? city.col + 1 : map.width - 1) + 1
        
        im[city.row][city.col] = -10.0
        
        for row in startRow..<endRow {
            for col in startCol..<endCol {
                if diplomacy == DiplomacyStatus.AtWar {
                    im[row][col] = -10.0
                }
            }
        }
        
        return im
    }
}
