import Foundation
import SQLite3

public class TerrainDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "terrain", loggerName: String(describing: type(of: self)))
    }
    
    public func getTerrains() throws -> [Terrain] {
        var terrains: [Terrain] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                terrain_id,
                tiled_id,
                terrain_type,
                food,
                shields,
                trade,
                movement_cost,
                defensive_bonus
            FROM
                terrain
            ORDER BY
                terrain_type
        """

        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let terrainId = getInt(stmt: stmt, colIndex: 0)
                let tiledId = getInt(stmt: stmt, colIndex: 1)
                // let food = getDouble(stmt: stmt, colIndex: 3)
                // let shields = getDouble(stmt: stmt, colIndex: 4)
                // let trade = getDouble(stmt: stmt, colIndex: 5)
                // let movementCost = getDouble(stmt: stmt, colIndex: 6)
                var terrainType = TerrainType.Grassland
                
                if let name = try getString(stmt: stmt, colIndex: 2) {
                    switch name {
                    case "Desert":
                        terrainType = TerrainType.Desert
                    case "Forest":
                        terrainType = TerrainType.Forest
                    case "Glacier":
                        terrainType = TerrainType.Glacier
                    case "Grass":
                        terrainType = TerrainType.Grassland
                    case "Hills":
                        terrainType = TerrainType.Hills
                    case "Jungle":
                        terrainType = TerrainType.Jungle
                    case "Mountain":
                        terrainType = TerrainType.Mountains
                    case "Water":
                        terrainType = TerrainType.Ocean
                    case "Plains":
                        terrainType = TerrainType.Plains
                    case "Swamp":
                        terrainType = TerrainType.Swamp
                    case "Tundra":
                        terrainType = TerrainType.Tundra
                    default: break
                    }
                    
                    terrains.append(Terrain(id: terrainId,
                                            tiledId: tiledId,
                                            name: name,
                                            type: terrainType))
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        return terrains
    }
}
