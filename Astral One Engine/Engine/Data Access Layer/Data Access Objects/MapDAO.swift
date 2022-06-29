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
                t.tile_id,
                t.game_id,
                t.map_id,
                t.row,
                t.col,
                t.terrain_id,
                t.has_river,
                t.special_resource,
                te.tiled_id,
                te.terrain_type,
                te.food,
                te.shields,
                te.trade,
                te.movement_cost,
                te.defensive_bonus
            FROM
                tile t
            INNER JOIN
                terrain te ON te.terrain_id = t.terrain_id
            WHERE
                t.game_id = \(gameId)
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let tileId = getInt(stmt: stmt, colIndex: 0)
                // let gameId = getInt(stmt: stmt, colIndex: 1)
                // let mapId = getInt(stmt: stmt, colIndex: 2)
                let row = getInt(stmt: stmt, colIndex: 3)
                let col = getInt(stmt: stmt, colIndex: 4)
                let terrainId = getInt(stmt: stmt, colIndex: 5)
                let hasRiver = getInt(stmt: stmt, colIndex: 6) == 1 ? true : false
                let tiledId = getInt(stmt: stmt, colIndex: 8)
                
                if let terrainTypeText = try getString(stmt: stmt, colIndex: 9) {
                    let terrainType = getTerrainType(terrainTypeText: terrainTypeText)
                    
                    maxRow = row > maxRow ? row : maxRow
                    maxCol = col > maxCol ? col : maxCol
                    
                    if let specialResourceText = try getString(stmt: stmt, colIndex: 7) {
                        let srType = getSpecialResource(specialResourceText: specialResourceText)
                        
                        tiles.append(Tile(id: tileId,
                                          position: Position(row: row, col: col),
                                          terrain: Terrain(id: terrainId,
                                                           tiledId: tiledId,
                                                           name: terrainTypeText,
                                                           type: terrainType),
                                          specialResource: srType,
                                          hasRiver: hasRiver))
                    }
                    else {
                        tiles.append(Tile(id: tileId,
                                          position: Position(row: row, col: col),
                                          terrain: Terrain(id: terrainId,
                                                           tiledId: tiledId,
                                                           name: terrainTypeText,
                                                           type: terrainType),
                                          hasRiver: hasRiver))
                    }
                }
                else {
                    fatalError("Terrain cannot be NULL.")
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        let returnMap = Map(mapId: 1, width: maxCol + 1, height: maxRow + 1)
        
        for tile in tiles {
            returnMap.add(tile: tile)
        }
        
        return returnMap
    }
    
    private func getTerrainType(terrainTypeText: String) -> TerrainType {
        switch terrainTypeText {
        case "Desert":
            return TerrainType.Desert
        case "Forest":
            return TerrainType.Forest
        case "Glacier":
            return TerrainType.Glacier
        case "Grass":
            return TerrainType.Grassland
        case "Hills":
            return TerrainType.Hills
        case "Jungle":
            return TerrainType.Jungle
        case "Mountain":
            return TerrainType.Mountains
        case "Water":
            return TerrainType.Ocean
        case "Plains":
            return TerrainType.Plains
        case "Swamp":
            return TerrainType.Swamp
        case "Tundra":
            return TerrainType.Tundra
        default:
            fatalError("Should not have gotten here.")
        }
    }
    
    private func getSpecialResource(specialResourceText: String) -> SpecialResourceType {
        switch specialResourceText {
        case "Buffalo":
            return SpecialResourceType.Buffalo
        case "Coal":
            return SpecialResourceType.Coal
        case "Fish":
            return SpecialResourceType.Fish
        case "Fruit":
            return SpecialResourceType.Fruit
        case "Furs":
            return SpecialResourceType.Furs
        case "Game":
            return SpecialResourceType.Game
        case "Gems":
            return SpecialResourceType.Gems
        case "Gold":
            return SpecialResourceType.Gold
        case "Iron":
            return SpecialResourceType.Iron
        case "Ivory":
            return SpecialResourceType.Ivory
        case "Oasis":
            return SpecialResourceType.Oasis
        case "Oil":
            return SpecialResourceType.Oil
        case "Peat":
            return SpecialResourceType.Peat
        case "Pheasant":
            return SpecialResourceType.Pheasant
        case "Silk":
            return SpecialResourceType.Silk
        case "Spice":
            return SpecialResourceType.Spice
        case "Whales":
            return SpecialResourceType.Whales
        case "Wheat":
            return SpecialResourceType.Wheat
        case "Wine":
            return SpecialResourceType.Wine
        default:
            fatalError("Should not have gotten here.")
        }
    }

    public func insert(gameId: Int, map: Map) throws -> Map {
        var mainStmt: OpaquePointer?
        var rowIdStmt: OpaquePointer?
        
        let mainSql =
            """
            INSERT INTO \(table)
            (game_id, map_id, row, col, terrain_id, has_river, special_resource)
            VALUES (?, ?, ?, ?, ?, ?, ?);
            """
        
        let gameIdCol: Int32 = 1
        let mapIdCol: Int32 = 2
        let rowCol: Int32 = 3
        let colCol: Int32 = 4
        let terrainIdCol: Int32 = 5
        let hasRiverCol: Int32 = 6
        let spResourceCol: Int32 = 7
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
                
                sqlite3_bind_int(mainStmt, gameIdCol, Int32(gameId))
                sqlite3_bind_int(mainStmt, mapIdCol, Int32(map.mapId))
                sqlite3_bind_int(mainStmt, rowCol, Int32(row))
                sqlite3_bind_int(mainStmt, colCol, Int32(col))
                sqlite3_bind_int(mainStmt, terrainIdCol, Int32(tile.terrain.id))
                
                if tile.hasRiver {
                    sqlite3_bind_int(mainStmt, hasRiverCol, Int32(1))
                }
                else {
                    sqlite3_bind_int(mainStmt, hasRiverCol, Int32(0))
                }
                
                if let sr = tile.specialResource {
                    sqlite3_bind_text(mainStmt, spResourceCol, sr.description, -1, SQLITE_TRANSIENT)
                }
                else {
                    sqlite3_bind_text(mainStmt, spResourceCol, nil, -1, SQLITE_TRANSIENT)
                }
                
                let stepResult = sqlite3_step(mainStmt)
                if stepResult == SQLITE_DONE {
                    if sqlite3_step(rowIdStmt) != SQLITE_ROW {
                        let errMsg = String(cString: sqlite3_errmsg(conn)!)
                        sqlite3_finalize(rowIdStmt)
                        
                        throw SQLiteError.Step(message: errMsg)
                    }
                }
                else {
                    print("\nError inserting row into \(table) table.  SQLite error code: \(stepResult).")
                }
                
                sqlite3_reset(mainStmt)
                sqlite3_reset(rowIdStmt)
            }
        }
        
        sqlite3_finalize(mainStmt)
        
        if sqlite3_exec (conn, "COMMIT TRANSACTION", nil, nil, nil) != SQLITE_OK {
            fatalError("Unable to COMMIT TRANSACTION on \(table) table.")
        }
        
        return try get(gameId: gameId)
    }
    
    public func importTiledMap(gameId: Int, filename: String) throws {
        let tilesetParser = TiledTilesetParser()
        let tileset = tilesetParser.parse()
        let mapParser = TiledMapParser(tiledTileset: tileset, filename: filename)
        
        // Import the Tiled map into the database
        let _ = try insert(gameId: gameId, map: mapParser.parse())
    }
}
