import Foundation
import Combine

public class Tile: Hashable, ObservableObject {
    public let id: Int
    public let position: Position
    public let terrain: Terrain
    public var specialResource: SpecialResourceType?
    public let hasRiver: Bool
    public private (set) var visibility = Visibility.FogOfWar
    private let baseMovementCost: Double
    public var food: Int
    public var production: Int
    public var trade: Int
    public let defenseBonus: Double
    public var city: City? = nil
    @Published public private (set) var hasFortress = false
    @Published public private (set) var roadType = RoadType.None
    
    public convenience init(position: Position, terrain: Terrain, hasRiver: Bool) {
        self.init(id: Constants.noId, position: position, terrain: terrain, hasRiver: hasRiver)
    }
    
    public init(id: Int, position: Position, terrain: Terrain, hasRiver: Bool) {
        self.id = id
        self.position = position
        self.terrain = terrain
        self.hasRiver = hasRiver
        
        if (hasRiver && terrain.type == TerrainType.Mountains) ||
            (hasRiver && terrain.type == TerrainType.Ocean) {
            var msg = "Rivers cannot be on ocean or mountain tiles.  "
            msg += "Problematic tile is at [\(position.row), \(position.col)]."
            fatalError(msg)
        }
        
        switch terrain.type {
        case TerrainType.Desert:
            food = 0
            production = 1
            trade = 0
            defenseBonus = 1.0
            baseMovementCost = 1.0
        case TerrainType.Forest:
            food = 1
            production = 2
            trade = 0
            defenseBonus = 1.5
            baseMovementCost = 1.0
        case TerrainType.Glacier:
            food = 0
            production = 0
            trade = 0
            defenseBonus = 1.0
            baseMovementCost = 1.0
        case TerrainType.Grassland:
            food = 2
            production = 0
            trade = 0
            defenseBonus = 1.0
            baseMovementCost = 1.0
        case TerrainType.Hills:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 2.0
            baseMovementCost = 1.0
        case TerrainType.Jungle:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.5
            baseMovementCost = 1.0
        case TerrainType.Mountains:
            food = 0
            production = 1
            trade = 0
            defenseBonus = 3.0
            baseMovementCost = 1.0
        case TerrainType.Ocean:
            food = 1
            production = 0
            trade = 2
            defenseBonus = 1.0
            baseMovementCost = 1.0
        case TerrainType.Plains:
            food = 1
            production = 1
            trade = 0
            defenseBonus = 1.0
            baseMovementCost = 1.0
        case TerrainType.Swamp:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.5
            baseMovementCost = 1.0
        case TerrainType.Tundra:
            food = 1
            production = 0
            trade = 0
            defenseBonus = 1.0
            baseMovementCost = 1.0
        case TerrainType.Unknown:
            food = 0
            production = 0
            trade = 0
            defenseBonus = 0.0
            baseMovementCost = 1.0
        }
    }
    
    public init(id: Int,
                position: Position,
                terrain: Terrain,
                specialResource: SpecialResourceType,
                hasRiver: Bool) {
        self.id = id
        self.position = position
        self.terrain = terrain
        self.specialResource = specialResource
        self.hasRiver = hasRiver
        
        if (hasRiver && terrain.type == TerrainType.Mountains) ||
            (hasRiver && terrain.type == TerrainType.Ocean) {
            var msg = "Rivers cannot be on ocean or mountain tiles.  "
            msg += "Problematic tile is at [\(position.row), \(position.col)]."
            fatalError(msg)
        }
        
        let errorMsg = "\(specialResource) cannot be added to a \(terrain.type) tile."
        
        switch terrain.type {
        case TerrainType.Desert:
            if specialResource == SpecialResourceType.Oasis {
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
                fatalError(errorMsg)
            }

            defenseBonus = 1.0
            baseMovementCost = 1.0
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
                fatalError(errorMsg)
            }
            
            defenseBonus = 1.5
            baseMovementCost = 1.0
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
                fatalError(errorMsg)
            }
            
            defenseBonus = 1.0
            baseMovementCost = 1.0
        case TerrainType.Grassland:
            food = 2
            production = 0
            trade = 0
            defenseBonus = 1.0
            baseMovementCost = 1.0
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
                fatalError(errorMsg)
            }
            
            defenseBonus = 2.0
            baseMovementCost = 1.0
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
                fatalError(errorMsg)
            }

            defenseBonus = 1.5
            baseMovementCost = 1.0
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
                fatalError(errorMsg)
            }
            
            defenseBonus = 3.0
            baseMovementCost = 1.0
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
                fatalError(errorMsg)
            }

            defenseBonus = 1.0
            baseMovementCost = 1.0
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
                fatalError(errorMsg)
            }
            
            defenseBonus = 1.0
            baseMovementCost = 1.0
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
                fatalError(errorMsg)
            }
            
            defenseBonus = 1.5
            baseMovementCost = 1.0
        case TerrainType.Tundra:
            if specialResource == SpecialResourceType.Furs {
                food = 2
                production = 0
                trade = 3
            }
            else if specialResource == SpecialResourceType.Game {
                food = 3
                production = 1
                trade = 0
            }
            else {
                fatalError(errorMsg)
            }

            defenseBonus = 1.0
            baseMovementCost = 1.0
        case TerrainType.Unknown:
            food = 0
            production = 0
            trade = 0
            defenseBonus = 0.0
            baseMovementCost = 1.0
        }
        
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(position.row)
        hasher.combine(position.col)
    }
    
    public static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.position.row == rhs.position.row && lhs.position.col == rhs.position.col
    }
    
    public func clone() -> Tile {
        if let sr = specialResource {
            return Tile(id: id,
                        position: position,
                        terrain: terrain,
                        specialResource: sr,
                        hasRiver: false)
        }
        else {
            return Tile(id: id,
                        position: position,
                        terrain: terrain,
                        hasRiver: false)
        }
    }
    
    public var score: Double {
        return Double(food) + Double(production) + Double(trade) + defenseBonus
    }
    
    private func getFood(terrain: Terrain) -> Int {
        return 0
    }
    
    internal func add(city: City) {
        self.city = city
    }
    
    internal func addRoad() {
        roadType = RoadType.Road
    }
    
    internal func addRailroad() {
        roadType = RoadType.Railroad
    }
    
    internal func addFortress() {
        hasFortress = true
    }
    
    public var canCreateCity: Bool {
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
    
    public var movementCost: Double {
        if roadType == RoadType.Railroad {
            return 0.0
        }
        else if roadType == RoadType.Road {
            return 1.0 / 3.0
        }
        
        return baseMovementCost
    }

}
