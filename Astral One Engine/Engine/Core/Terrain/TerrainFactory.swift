import Foundation

public class TerrainFactory {
    public static func create(terrainType: TerrainType) -> Terrain {
        switch terrainType {
        case .Desert:
            return Terrain(name: "Desert", food: 0, shields: 1, trade: 0, movementCost: 1.0)
        case .Forest:
            return Terrain(name: "Forest", food: 0, shields: 1, trade: 0, movementCost: 2.0)
        case .Glacier:
            return Terrain(name: "Glacier", food: 0, shields: 1, trade: 0, movementCost: 2.0)
        case .Grassland:
            return Terrain(name: "Grasslands", food: 0, shields: 1, trade: 0, movementCost: 1.0)
        case .Hills:
            return Terrain(name: "Hills", food: 0, shields: 1, trade: 0, movementCost: 2.0)
        case .Jungle:
            return Terrain(name: "Jungle", food: 0, shields: 1, trade: 0, movementCost: 2.0)
        case .Mountains:
            return Terrain(name: "Mountains", food: 0, shields: 1, trade: 0, movementCost: 3.0)
        case .Ocean:
            return Terrain(name: "Ocean", food: 0, shields: 1, trade: 0, movementCost: 1.0)
        case .Plains:
            return Terrain(name: "Plains", food: 0, shields: 1, trade: 0, movementCost: 1.0)
        case .River:
            return Terrain(name: "River", food: 0, shields: 1, trade: 0, movementCost: 1.0)
        case .Swamp:
            return Terrain(name: "Swamp", food: 0, shields: 1, trade: 0, movementCost: 2.0)
        case .Tank:
            return Terrain(name: "Tank", food: 0, shields: 1, trade: 0, movementCost: 1.0)
        case .Tundra:
            return Terrain(name: "Tundra", food: 0, shields: 1, trade: 0, movementCost: 1.0)
        case .Water:
            return Terrain(name: "Water", food: 0, shields: 1, trade: 0, movementCost: 1.0)
        case .None:
            return Terrain(name: "None", food: 0, shields: 0, trade: 0, movementCost: 0.0)
        }
    }
}
