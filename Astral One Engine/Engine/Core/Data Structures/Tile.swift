import Foundation

public class Tile: Hashable {
    public let row: Int
    public let col: Int
    public let terrain: Terrain
    
    private var units: [Unit] = []
    private var movementModifier: MovementModifier?
    
    public init(row: Int, col: Int, terrain: Terrain) {
        self.row = row
        self.col = col
        self.terrain = terrain
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
    
    public static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
    
    public func addUnit(unit: Unit) {
        units.append(unit)
    }
    
    public func add(movementModifier: MovementModifier) {
        self.movementModifier = movementModifier
    }
    
    public func getUnits() -> [Unit] {
        return units
    }
    
    public func getMovementCost() -> Double {
        var movementCost = terrain.movementCost
        
        if let modifier = movementModifier {
            movementCost = modifier.movementCost
        }
        
        return movementCost <= 0.0 ? Constants.minMovementCost : movementCost
    }

}
