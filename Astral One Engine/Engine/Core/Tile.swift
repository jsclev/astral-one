import Foundation
import Combine

public class Tile: Hashable, ObservableObject {
    public let id: Int
    public private (set) var visibility = Visibility.FogOfWar
    public let position: Position
    public let terrain: Terrain
    public var specialResource: SpecialResourceType?
    public var food: Int
    public var production: Int
    public var trade: Int
    private var movementModifier: MovementModifier?
    public let defenseBonus: Double
    public var city: City? = nil
    
    public init(position: Position, terrain: Terrain) {
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
        case TerrainType.Unknown:
            food = 0
            production = 0
            trade = 0
            defenseBonus = 0.0
        }
    }
    
    public init(id: Int, position: Position, terrain: Terrain) {
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
        case TerrainType.Unknown:
            food = 0
            production = 0
            trade = 0
            defenseBonus = 0.0
        }
    }
    
    public init(id: Int,
                position: Position,
                terrain: Terrain,
                specialResource: SpecialResourceType) {
        self.id = id
        self.position = position
        self.terrain = terrain
        self.specialResource = specialResource
        
//        var stats: [Double] = [0.0, 0.0, 0.0, 0.0]
        
        switch terrain.type {
        case TerrainType.Desert:
            if specialResource == SpecialResourceType.Oasis {
//                stats = [3.0, 1.0, 0.0, 1.0]
                food = 3
                production = 1
                trade = 0
            }
            else if specialResource == SpecialResourceType.Oil {
                food = 0
                production = 4
                trade = 0
            }
            else {
                fatalError("\(specialResource) cannot be added to a \(terrain.type) tile.")
            }

            defenseBonus = 1.0
        case TerrainType.Forest:
            if specialResource == SpecialResourceType.Pheasant {
                food = 3
                production = 2
                trade = 0
            }
            else if specialResource == SpecialResourceType.Silk {
                food = 1
                production = 2
                trade = 3
            }
            else {
                fatalError("\(specialResource) cannot be added to a \(terrain.type) tile.")
            }
            
            defenseBonus = 1.5
        case TerrainType.Glacier:
            if specialResource == SpecialResourceType.Ivory {
                food = 1
                production = 1
                trade = 4
            }
            else if specialResource == SpecialResourceType.Oil {
                food = 0
                production = 4
                trade = 0
            }
            else {
                fatalError("\(specialResource) cannot be added to a \(terrain.type) tile.")
            }
            
            defenseBonus = 1.0
        case TerrainType.Grassland:
            food = 2
            production = 0
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Hills:
            if specialResource == SpecialResourceType.Coal {
                food = 1
                production = 2
                trade = 0
            }
            else if specialResource == SpecialResourceType.Wine {
                food = 1
                production = 0
                trade = 4
            }
            else {
                fatalError("\(specialResource) cannot be added to a \(terrain.type) tile.")
            }
            
            defenseBonus = 2.0
        case TerrainType.Jungle:
            if specialResource == SpecialResourceType.Gems {
                food = 1
                production = 0
                trade = 4
            }
            else if specialResource == SpecialResourceType.Fruit {
                food = 4
                production = 0
                trade = 1
            }
            else {
                fatalError("\(specialResource) cannot be added to a \(terrain.type) tile.")
            }

            defenseBonus = 1.5
        case TerrainType.Mountains:
            if specialResource == SpecialResourceType.Gold {
                food = 0
                production = 1
                trade = 6
            }
            else if specialResource == SpecialResourceType.Iron {
                food = 0
                production = 4
                trade = 0
            }
            else {
                fatalError("\(specialResource) cannot be added to a \(terrain.type) tile.")
            }
            
            defenseBonus = 3.0
        case TerrainType.Ocean:
            if specialResource == SpecialResourceType.Fish {
                food = 3
                production = 0
                trade = 2
            }
            else if specialResource == SpecialResourceType.Whales {
                food = 2
                production = 2
                trade = 3
            }
            else {
                fatalError("\(specialResource) cannot be added to a \(terrain.type) tile.")
            }

            defenseBonus = 1.0
        case TerrainType.Plains:
            if specialResource == SpecialResourceType.Buffalo {
                food = 1
                production = 3
                trade = 0
            }
            else if specialResource == SpecialResourceType.Wheat {
                food = 3
                production = 1
                trade = 0
            }
            else {
                fatalError("\(specialResource) cannot be added to a \(terrain.type) tile.")
            }
            
            defenseBonus = 1.0
        case TerrainType.River:
            food = 0
            production = 0
            trade = 1
            defenseBonus = 1.0
        case TerrainType.Swamp:
            if specialResource == SpecialResourceType.Peat {
                food = 1
                production = 4
                trade = 0
            }
            else if specialResource == SpecialResourceType.Spice {
                food = 3
                production = 0
                trade = 4
            }
            else {
                fatalError("\(specialResource) cannot be added to a \(terrain.type) tile.")
            }
            
            defenseBonus = 1.5
        case TerrainType.Tundra:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.0
        case TerrainType.Unknown:
            food = 0
            production = 0
            trade = 0
            defenseBonus = 0.0
        }
        
//        food = Int(stats[0])
//        production = Int(stats[1])
//        trade = Int(stats[2])
//        defenseBonus = stats[3]
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(position.row)
        hasher.combine(position.col)
    }
    
    public static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.position.row == rhs.position.row && lhs.position.col == rhs.position.col
    }
    
    public func clone() -> Tile {
        if let sp = specialResource {
            return Tile(id: id,
                        position: position,
                        terrain: terrain,
                        specialResource: sp)
        }
        else {
            return Tile(id: id,
                        position: position,
                        terrain: terrain)
        }
    }
    
    public func getScore() -> Double {
        return Double(food) + Double(production) + Double(trade) + defenseBonus
    }
    
    private func getFood(terrain: Terrain) -> Int {
        return 0
    }
    
    internal func add(city: City) {
        self.city = city
    }
    
    public func canBuildCity() -> Bool {
        if terrain.type == TerrainType.Ocean {
            return false
        }
        
        if city != nil {
            return false
        }
        
        return true
    }
    
    public func set(visibility: Visibility) {
        self.visibility = visibility
    }

    public func add(movementModifier: MovementModifier) {
        self.movementModifier = movementModifier
    }
    
    public func getMovementCost() -> Double {
        var movementCost = 0.0
        
        if let modifier = movementModifier {
            movementCost = modifier.movementCost
        }
        
        return movementCost <= 0.0 ? Constants.minMovementCost : movementCost
    }

}
