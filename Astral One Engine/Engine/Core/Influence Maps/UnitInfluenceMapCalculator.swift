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
    
    public func getInfluenceMap() throws -> [[Double]] {
        let threatMap: [[Double]] = Array(repeating: Array(repeating: 0.0, count: map.width), count: map.height)
        
//        if try map.tile(row: unit.position.row, col: unit.position.col).getUnits().contains(unit) {
//            for row in 0..<map.height {
//                for col in 0..<map.width {
//                    if agent.getDiplomacyStatus(between: unit) == DiplomacyStatus.AtWar {
//                        let movementCost = unit.getChebyshevDistance(toRow: row, toCol: col)
//                        threatMap[row][col] = getThreat(distance: movementCost)
//                    }
//                }
//            }
//        }
        
        return threatMap
    }
    
    public static func sum(map1: [[Double]], map2: [[Double]]) -> [[Double]] {
        let width = map1.count
        
        if width > 0 {
            let height = map1[0].count
            var sum: [[Double]] = Array(repeating: Array(repeating: 0.0, count: width), count: height)

            for row in 0..<height {
                for col in 0..<width {
                    sum[row][col] = map1[row][col] + map2[row][col]
                }
            }
            
            return sum
        }
        
        return [[]]
    }
    
    private func getThreat(distance: Int) -> Double {
        let normalizedThreat = -1 / (1 + exp(3 * (1.8 * Double(distance) - 2.5)))
        
        return (unit.attack / 3) * normalizedThreat
    }
    
    public func logInfluenceMap(theMap: [[Double]]) {
        var line1 = "-"
        var line2 = ""
        var line3 = ""
        var line4 = ""
        var line5 = ""
        
        for _ in 0..<theMap.count {
            line1 += "----------------"
        }
        
        print(line1)
        line1 = ""
        
        for i in 0..<theMap.count {
            line2 = "|"
            line3 = "|"
            line4 = "|"
            line5 = "-"
            
            for j in 0..<theMap[i].count {
                let formattedNum = String(format: "%.7f", theMap[i][j])
                
                line2 += "               |"
                
                if formattedNum.count == 9 {
                    line3 += "  " + formattedNum + "    |"
                }
                else if formattedNum.count == 10 {
                    line3 += "  " + formattedNum + "   |"
                }
                line4 += "               |"
                line5 += "----------------"
            }
            
            print(line2)
            print(line3)
            print(line4)
            print(line5)
            
            line1 = ""
            line2 = ""
            line3 = ""
            line4 = ""
            line5 = ""
        }
    }
}
