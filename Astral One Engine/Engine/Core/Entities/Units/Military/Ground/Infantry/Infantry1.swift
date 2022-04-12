import Foundation

public class Infantry1: Unit {
    public init(playerId: Int,
                name: String,
                row: Int,
                col: Int) {
        super.init(playerId: playerId,
                   name: name,
                   cost: 10,
                   maxHp: 10,
                   attackRating: 1,
                   defenseRating: 1,
                   fp: 1,
                   maxMovementPoints: 1.0,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getInfluenceMap(map: Map, on: Unit) -> [[Float]] {
        var threatMap: [[Float]] = Array(repeating: Array(repeating: 0.0, count: map.width), count: map.height)
        
        if getDiplomacyStatus(between: on) == DiplomacyStatus.AtWar {
            for y in 0..<map.height {
                for x in 0..<map.width {
                    let movementCost = map.getDistance(fromRow: row,
                                                       fromCol: col,
                                                       toRow: y,
                                                       toCol: x)
                    threatMap[y][x] = getThreat(distance: movementCost)
                }
            }
        }
        
        return threatMap
    }
    
    private func getThreat(distance: Int) -> Float {
        -1 / (1 + exp(3 * (1.8 * Float(distance) - 2.0)))
    }
    
    public func logInfluenceMap(theMap: [[Float]]) {
        var line1 = "-"
        var line2 = ""
        var line3 = ""
        var line4 = ""
        var line5 = ""
        
        for _ in 0..<theMap.count {
            line1 += "---------------"
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
                
                line2 += "              |"
                line3 += "  " + formattedNum + "  |"
                line4 += "              |"
                line5 += "---------------"
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
