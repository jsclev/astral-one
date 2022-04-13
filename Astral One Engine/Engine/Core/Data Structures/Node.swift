import Foundation

public class Node: Hashable {
    public let row: Int
    public let col: Int
    public let terrain: Terrain
    
    private var units: [Unit] = []
    private var enemyHP: Float = 0.0
    private var enemyLandAttack: Float = 0.0
    private var enemyLandDefense: Float = 0.0
    private var avgEnemyMovement: Float = 0.0
    
    public init(row: Int, col: Int, terrain: Terrain) {
        self.row = row
        self.col = col
        self.terrain = terrain
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
    
    public func getUnits() -> [Unit] {
        return units
    }
    
    public func getMovementCost() -> Float {
        return Float(terrain.movementCost)
    }
    
    public func addUnit(unit: Unit) {
        units.append(unit)
    }
    
    public func getEnemyLandAttack() -> Float {
        return enemyLandAttack
    }
    
    public func getEnemyLandDefense() -> Float {
        return enemyLandDefense
    }

}
