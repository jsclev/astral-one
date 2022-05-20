import Foundation
import SwiftUI

public class TerrainFactory {
    public static func create(terrainType: TerrainType) throws -> Terrain {
        let terrains = try Constants.db.terrainDao.getTerrains()
        
        switch terrainType {
        case .Desert:
            for terrain in terrains { if terrain.type == TerrainType.Desert { return terrain} }
        case .Forest:
            for terrain in terrains { if terrain.type == TerrainType.Forest { return terrain} }
        case .Glacier:
            for terrain in terrains { if terrain.type == TerrainType.Glacier { return terrain} }
        case .Grassland:
            for terrain in terrains { if terrain.type == TerrainType.Grassland { return terrain} }
        case .Hills:
            for terrain in terrains { if terrain.type == TerrainType.Hills { return terrain} }
        case .Jungle:
            for terrain in terrains { if terrain.type == TerrainType.Jungle { return terrain} }
        case .Mountains:
            for terrain in terrains { if terrain.type == TerrainType.Mountains { return terrain} }
        case .Ocean:
            for terrain in terrains { if terrain.type == TerrainType.Ocean { return terrain} }
        case .Plains:
            for terrain in terrains { if terrain.type == TerrainType.Plains { return terrain} }
        case .River:
            for terrain in terrains { if terrain.type == TerrainType.River { return terrain} }
        case .Swamp:
            for terrain in terrains { if terrain.type == TerrainType.Swamp { return terrain} }
        case .Tundra:
            for terrain in terrains { if terrain.type == TerrainType.Tundra { return terrain} }
        }
        
        return Terrain(id: 0,
                       tiledId: 0,
                       name: "Hello",
                       type: TerrainType.Grassland,
                       food: 0.0,
                       shields: 0.0,
                       trade: 0.0,
                       movementCost: 0.0,
                       defenseBonus: 1.0)
    }
}
