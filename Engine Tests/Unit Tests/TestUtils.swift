import Foundation
import XCTest
import Engine

public class TestUtils {
    static func getDb() -> Db {
        Db(fullRefresh: true)
    }
    
    internal static func makeTile(_ row: Int,
                                  _ col: Int,
                                  _ terrainType: TerrainType) -> Tile {
        return Tile(id: 1,
                    position: Position(row: row, col: col),
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test \(terrainType)",
                                     type: terrainType),
                                     hasRiver: false)
    }
    
    internal static func makeTile(_ row: Int,
                                  _ col: Int,
                                  _ terrainType: TerrainType,
                                  _ specialResource: SpecialResourceType) -> Tile {
        return Tile(id: 1,
                    position: Position(row: row, col: col),
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test \(terrainType)",
                                     type: terrainType),
                                     specialResource: specialResource,
                                     hasRiver: false)
    }
}
