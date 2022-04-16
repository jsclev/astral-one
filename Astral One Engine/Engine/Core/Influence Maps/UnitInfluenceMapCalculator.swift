import Foundation

public class UnitInfluenceMapCalculator: InfluenceMapCalculator {
    let map: Map
    let unit: Unit
    let agent: Unit
    
    public init(map: Map, unit: Unit, agent: Unit) {
        self.map = map
        self.unit = unit
        self.agent = agent
    }
    
    public func getInfluenceMap() -> [[Double]] {
        let threatMap: [[Double]] = Array(repeating: Array(repeating: 0.0, count: map.width), count: map.height)
        
//        if agent.getDiplomacyStatus(between: unit) == DiplomacyStatus.AtWar {
//            for row in 0..<map.height {
//                for col in 0..<map.width {
//                    if let node = map.getNode(row: row, col: col) {
//                        let tiles = node.getTiles()
//                        
//                        if tiles.count > 0 {
//                            let terrainType = tiles[0].spec.terrainType
//                            
//                            if terrainType == TerrainType.Grassland {
//                                threatMap[row][col] = -1.0
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
        return threatMap
    }
}
