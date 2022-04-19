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
                let dbTerrainType = try getString(stmt: stmt, colIndex: 1)
                let food = getDouble(stmt: stmt, colIndex: 2)
                let shields = getDouble(stmt: stmt, colIndex: 3)
                let trade = getDouble(stmt: stmt, colIndex: 4)
                let movementCost = getDouble(stmt: stmt, colIndex: 5)
                var terrainType = TerrainType.None
                
                switch dbTerrainType {
                case "Desert":
                    terrainType = TerrainType.Desert
                case "Forest":
                    terrainType = TerrainType.Forest
                case "Glacier":
                    terrainType = TerrainType.Glacier
                case "Grassland":
                    terrainType = TerrainType.Grassland
                case "Hills":
                    terrainType = TerrainType.Hills
                case "Jungle":
                    terrainType = TerrainType.Jungle
                case "Mountains":
                    terrainType = TerrainType.Mountains
                case "Ocean":
                    terrainType = TerrainType.Ocean
                case "Plains":
                    terrainType = TerrainType.Plains
                case "River":
                    terrainType = TerrainType.River
                case "Swamp":
                    terrainType = TerrainType.Swamp
                case "Tundra":
                    terrainType = TerrainType.Tundra
                default: break
                }
                
                terrains.append(Terrain(id: terrainId,
                                        type: terrainType,
                                        food: food,
                                        shields: shields,
                                        trade: trade,
                                        movementCost: movementCost))
            }
        }
        
        sqlite3_finalize(stmt)
        
        return terrains
    }
}
