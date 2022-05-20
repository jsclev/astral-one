import Foundation
import SQLite3

public class MapDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "tile", loggerName: String(describing: type(of: self)))
    }
    
    public func get(gameId: Int) throws -> Map {
        var tiles: [Tile] = []
        var maxRow = 0
        var maxCol = 0
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                t.tile_id, t.game_id, t.map_id, t.row, t.col, t.terrain_id, t.has_river,
                te.tiled_id, te.terrain_type, te.food, te.shields, te.trade, te.movement_cost,
                te.defensive_bonus
            FROM
                tile t
            INNER JOIN
                terrain te ON te.terrain_id = t.terrain_id
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let tileId = getInt(stmt: stmt, colIndex: 0)
                // let gameId = getInt(stmt: stmt, colIndex: 1)
                // let mapId = getInt(stmt: stmt, colIndex: 2)
                let row = getInt(stmt: stmt, colIndex: 3)
                let col = getInt(stmt: stmt, colIndex: 4)
                let terrainId = getInt(stmt: stmt, colIndex: 5)
                let tiledId = getInt(stmt: stmt, colIndex: 7)
                let food = getDouble(stmt: stmt, colIndex: 9)
                let shields = getDouble(stmt: stmt, colIndex: 10)
                let trade = getDouble(stmt: stmt, colIndex: 11)
                let movementCost = getDouble(stmt: stmt, colIndex: 12)
                var terrainType = TerrainType.Grassland
                
                if let terrainTypeText = try getString(stmt: stmt, colIndex: 8) {
                    switch terrainTypeText {
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
                    case "River":
                        terrainType = TerrainType.River
                    case "Swamp":
                        terrainType = TerrainType.Swamp
                    case "Tundra":
                        terrainType = TerrainType.Tundra
                    default: break
                    }
                    
                    maxRow = row > maxRow ? row : maxRow
                    maxCol = col > maxCol ? col : maxCol
                    tiles.append(Tile(id: tileId,
                                      position: Position(row: row, col: col),
                                      terrain: Terrain(id: terrainId,
                                                       tiledId: tiledId,
                                                       name: terrainTypeText,
                                                       type: terrainType,
                                                       food: food,
                                                       shields: shields,
                                                       trade: trade,
                                                       movementCost: movementCost,
                                                       defenseBonus: 1.0)))
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        let returnMap = Map(mapId: 1, width: maxCol + 1, height: maxRow + 1)
        
        for tile in tiles {
            try returnMap.add(tile: tile)
        }
        
        return returnMap
    }
        
    public func insert(map: Map) throws -> Map {
        var tileId = -1
        var mainStmt: OpaquePointer?
        var rowIdStmt: OpaquePointer?
        let returnMap = Map(mapId: 1, width: map.width, height: map.height)
        
        let mainSql =
            """
            INSERT INTO \(table)
            (game_id, map_id, row, col, terrain_id, has_river)
            VALUES (?, ?, ?, ?, ?, ?);
            """
        
        let rowIdSql = "SELECT last_insert_rowid()"
        
        if sqlite3_exec(conn, "BEGIN TRANSACTION", nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(rowIdStmt)
            
            throw SQLiteError.Prepare(message: errMsg)
        }
        
        if sqlite3_prepare_v2(conn, rowIdSql, -1, &rowIdStmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(rowIdStmt)
            
            throw SQLiteError.Prepare(message: errMsg)
        }
        
        if sqlite3_prepare_v2(conn, mainSql, -1, &mainStmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(rowIdStmt)
            
            throw SQLiteError.Prepare(message: errMsg)
        }
        
        for row in 0..<map.height {
            for col in 0..<map.width {
                let tile = map.tile(at: Position(row: row, col: col))
                
                sqlite3_bind_int(mainStmt, 1, Int32(1))
                sqlite3_bind_int(mainStmt, 2, Int32(1))
                sqlite3_bind_int(mainStmt, 3, Int32(row))
                sqlite3_bind_int(mainStmt, 4, Int32(col))
                sqlite3_bind_int(mainStmt, 5, Int32(tile.terrain.id))
                sqlite3_bind_int(mainStmt, 6, Int32(0))
                
                if sqlite3_step(mainStmt) == SQLITE_DONE {
                    if sqlite3_step(rowIdStmt) == SQLITE_ROW {
                        tileId = getInt(stmt: rowIdStmt, colIndex: 0)
                        try returnMap.add(tile: Tile(id: tileId,
                                                     position: Position(row: row, col: col),
                                                     terrain: tile.terrain))
                    }
                    else {
                        let errMsg = String(cString: sqlite3_errmsg(conn)!)
                        sqlite3_finalize(rowIdStmt)
                        
                        throw SQLiteError.Step(message: errMsg)
                    }
                }
                else {
                    print("\nCould not insert row.")
                }
                
                sqlite3_reset(mainStmt)
                sqlite3_reset(rowIdStmt)
            }
        }
        
        sqlite3_finalize(mainStmt)
        
        if sqlite3_exec (conn, "COMMIT TRANSACTION", nil, nil, nil) != SQLITE_OK {
            print("Error!!!!")
        }
        
        return returnMap
    }
    
    public func importTiledMap(filename: String) throws {
        let tilesetParser = TiledTilesetParser(filename)
        let tileset = tilesetParser.parse()
        let mapParser = TiledMapParser(tiledTileset: tileset, filename: filename)
        
        // Import the Tiled map into the database
        let _ = try insert(map: mapParser.parse())
    }
}
