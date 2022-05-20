import Foundation

public class Tile: Hashable {
    public let id: Int
    public let position: Position
    public let terrain: Terrain
    public var specialResource: SpecialResource?
    public var food: Int
    public var production: Int
    public var trade: Int
    private var movementModifier: MovementModifier?
    public let defenseBonus: Double
    
    public init(position: Position,
                terrain: Terrain) {
        self.id = -1
        self.position = position
        self.terrain = terrain
        
        switch terrain.type {
        case TerrainType.Desert:
            food = 0
            production = 1
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Forest:
            food = 1
            production = 2
            trade = 0
            defenseBonus = 1.5
        case TerrainType.Glacier:
            food = 0
            production = 0
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Grassland:
            food = 2
            production = 0
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Hills:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 2.0
        case TerrainType.Jungle:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.5
        case TerrainType.Mountains:
            food = 0
            production = 1
            trade = 0
            defenseBonus = 3.0
        case TerrainType.Ocean:
            food = 1
            production = 0
            trade = 2
            defenseBonus = 1.0
        case TerrainType.Plains:
            food = 1
            production = 1
            trade = 0
            defenseBonus = 1.0
        case TerrainType.River:
            food = 0
            production = 0
            trade = 1
            defenseBonus = 1.0
        case TerrainType.Swamp:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.5
        case TerrainType.Tundra:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.0
        }
    }
    
    public init(id: Int,
                position: Position,
                terrain: Terrain) {
        self.id = id
        self.position = position
        self.terrain = terrain
        
        switch terrain.type {
        case TerrainType.Desert:
            food = 0
            production = 1
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Forest:
            food = 1
            production = 2
            trade = 0
            defenseBonus = 1.5
        case TerrainType.Glacier:
            food = 0
            production = 0
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Grassland:
            food = 2
            production = 0
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Hills:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 2.0
        case TerrainType.Jungle:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.5
        case TerrainType.Mountains:
            food = 0
            production = 1
            trade = 0
            defenseBonus = 3.0
        case TerrainType.Ocean:
            food = 1
            production = 0
            trade = 2
            defenseBonus = 1.0
        case TerrainType.Plains:
            food = 1
            production = 1
            trade = 0
            defenseBonus = 1.0
        case TerrainType.River:
            food = 0
            production = 0
            trade = 1
            defenseBonus = 1.0
        case TerrainType.Swamp:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.5
        case TerrainType.Tundra:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.0
        }
    }
    
    public init(id: Int,
                position: Position,
                terrain: Terrain,
                specialResource: SpecialResource) {
        self.id = id
        self.position = position
        self.terrain = terrain
        self.specialResource = specialResource
        
        switch terrain.type {
        case TerrainType.Desert:
            food = 0
            production = 1
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Forest:
            food = 1
            production = 2
            trade = 0
            defenseBonus = 1.5
        case TerrainType.Glacier:
            food = 0
            production = 0
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Grassland:
            food = 2
            production = 0
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Hills:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 2.0
        case TerrainType.Jungle:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.5
        case TerrainType.Mountains:
            food = 0
            production = 1
            trade = 0
            defenseBonus = 3.0
        case TerrainType.Ocean:
            food = 1
            production = 0
            trade = 2
            defenseBonus = 1.0
        case TerrainType.Plains:
            food = 1
            production = 1
            trade = 0
            defenseBonus = 1.0
        case TerrainType.River:
            food = 0
            production = 0
            trade = 1
            defenseBonus = 1.0
        case TerrainType.Swamp:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.5
        case TerrainType.Tundra:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.0
        }
    }
    
    private func getFood(terrain: Terrain) -> Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(position.row)
        hasher.combine(position.col)
    }
    
    public static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.position.row == rhs.position.row && lhs.position.col == rhs.position.col
    }
    
    public func add(movementModifier: MovementModifier) {
        self.movementModifier = movementModifier
    }
    
    public func getMovementCost() -> Double {
        var movementCost = terrain.movementCost
        
        if let modifier = movementModifier {
            movementCost = modifier.movementCost
        }
        
        return movementCost <= 0.0 ? Constants.minMovementCost : movementCost
    }

}
