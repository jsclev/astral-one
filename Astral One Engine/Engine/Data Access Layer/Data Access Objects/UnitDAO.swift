import Foundation
import SQLite3

public class UnitDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "unit", loggerName: String(describing: type(of: self)))
    }
    
    public func get(mapId: Int) throws -> Map {
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
                                                       type: terrainType),
                                      hasRiver: false))
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
    
    public func insert(settler: Settler) throws -> Settler {
        var unitId = Constants.noId
        
        var sql = "INSERT INTO unit (" +
        "game_id, player_id, unit_type_id, tile_id" +
        ") VALUES "
        
        // FIXME: Need to fix the unit_type_id and tile_id here
        sql += "("
        sql += getSql(val: settler.player.game.gameId, postfix: ", ")
        sql += getSql(val: settler.player.playerId, postfix: ", ")
        sql += getSql(val: 1, postfix: ", ")
        sql += getSql(val: 1, postfix: "")
        sql += "), "
        
        sql = getCleanedSql(sql)
        
        do {
            unitId = try insertOneRow(sql: sql)
        }
        catch SQLiteError.Prepare(let message) {
            var errMsg = "Failed to compile SQL to insert rows into the unit table.  "
            errMsg += "SQLite error message: " + message
            throw DbError.Db(message: errMsg)
        }
        catch SQLiteError.Step(let message) {
            var errMsg = "Failed to execute SQL to insert rows into the unit table.  "
            errMsg += "SQLite error message: " + message
            throw DbError.Db(message: errMsg)
        }
        
        return Settler(id: unitId,
                       game: settler.game,
                       player: settler.player,
                       theme: settler.theme,
                       name: settler.name,
                       position: settler.position)
    }
    
    public func insert(engineer: Engineer) throws -> Engineer {
        var unitId = Constants.noId
        
        var sql = "INSERT INTO unit (" +
        "game_id, player_id, unit_type_id, tile_id" +
        ") VALUES "
        
        sql += "("
        sql += getSql(val: 1, postfix: ", ")
        sql += getSql(val: engineer.player.playerId, postfix: ", ")
        sql += getSql(val: 1, postfix: ", ")
        sql += getSql(val: 1, postfix: "")
        sql += "), "
        
        sql = getCleanedSql(sql)
        
        do {
            unitId = try insertOneRow(sql: sql)
        }
        catch SQLiteError.Prepare(let message) {
            var errMsg = "Failed to compile SQL to insert rows into the unit table.  "
            errMsg += "SQLite error message: " + message
            throw DbError.Db(message: errMsg)
        }
        catch SQLiteError.Step(let message) {
            var errMsg = "Failed to execute SQL to insert rows into the unit table.  "
            errMsg += "SQLite error message: " + message
            throw DbError.Db(message: errMsg)
        }
        
        return Engineer(id: unitId,
                        game: engineer.game,
                        player: engineer.player,
                        theme: engineer.theme,
                        name: engineer.name,
                        position: engineer.position)
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
                        returnMap.add(tile: Tile(id: tileId,
                                                 position: Position(row: row, col: col),
                                                 terrain: tile.terrain,
                                                 hasRiver: false))
                    }
                    else {
                        let errMsg = String(cString: sqlite3_errmsg(conn)!)
                        sqlite3_finalize(rowIdStmt)
                        
                        throw SQLiteError.Step(message: errMsg)
                    }
                }
                else {
                    print("\nCould not insert row into \(table) table.")
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
    
    public func getUnits(game: Game) throws -> [Unit] {
        var units: [Unit] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                unit.unit_id,
                unit.game_id,
                unit.tile_id,
                unit.unit_type_id,
                unit_type.name,
                unit_type.display_name,
                tile.row,
                tile.col,
                tile.terrain_id,
                theme.theme_id,
                theme.name
            FROM
                unit
            INNER JOIN
                unit_type ON unit_type.unit_type_id = unit.unit_type_id
            INNER JOIN
                theme ON theme.theme_id = unit_type.theme_id
            LEFT OUTER JOIN
                tile ON tile.tile_id = unit.tile_id
            WHERE
                unit.game_id = 1
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                //                let unitId = getInt(stmt: stmt, colIndex: 0)
                //                let gameId = getInt(stmt: stmt, colIndex: 1)
                //                let tileId = getInt(stmt: stmt, colIndex: 2)
                //                let unitTypeId = getInt(stmt: stmt, colIndex: 3)
                let row = getInt(stmt: stmt, colIndex: 6)
                let col = getInt(stmt: stmt, colIndex: 7)
                let themeId = getInt(stmt: stmt, colIndex: 9)
                //                var terrainType = TerrainType.None
                
                if let unitTypeName = try getString(stmt: stmt, colIndex: 4),
                   let unitTypeDisplayName = try getString(stmt: stmt, colIndex: 5),
                   let themeName = try getString(stmt: stmt, colIndex: 10) {
                    let theme = Theme(id: themeId, name: themeName)
                    units.append(getUnit(game: game,
                                         theme: theme,
                                         typeName: unitTypeName,
                                         name: unitTypeDisplayName,
                                         row: row,
                                         col: col))
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        return units
    }
    
    private func getUnit(game: Game,
                         theme: Theme,
                         typeName: String,
                         name: String,
                         row: Int,
                         col: Int) -> Unit {
        let map = Map(mapId: 1, width: 1, height: 1)
        let player = Player(playerId: 1, game: game, map: map)
        
        switch typeName {
        case "Air1":
            return Air1(game: game,
                        player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "Air2":
            return Air2(game: game,
                        player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "Air3":
            return Air3(game: game,
                        player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "Air4":
            return Air4(game: game,
                        player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "Air5":
            return Air5(game: game,
                        player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "AircraftCarrier":
            return AircraftCarrier(game: game,
                                   player: player,
                                   theme: theme,
                                   name: name,
                                   position: Position(row: row, col: col))
        case "AlpineTroop":
            return AlpineTroop(game: game,
                               player: player,
                               theme: theme,
                               name: name,
                               position: Position(row: row, col: col))
        case "Artillery1":
            return Artillery1(game: game,
                              player: player,
                              theme: theme,
                              name: name,
                              position: Position(row: row, col: col))
        case "Artillery2":
            return Artillery2(game: game,
                              player: player,
                              theme: theme,
                              name: name,
                              position: Position(row: row, col: col))
        case "Artillery3":
            return Artillery3(game: game,
                              player: player,
                              theme: theme,
                              name: name,
                              position: Position(row: row, col: col))
        case "Artillery4":
            return Artillery4(game: game,
                              player: player,
                              theme: theme,
                              name: name,
                              position: Position(row: row, col: col))
        case "Crusader":
            return Crusader(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry1":
            return Cavalry1(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry2":
            return Cavalry2(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry3":
            return Cavalry3(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry4":
            return Cavalry4(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry5":
            return Cavalry5(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry6":
            return Cavalry6(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry7":
            return Cavalry7(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry8":
            return Cavalry8(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "CityCreator":
            return Settler(game: game,
                           player: player,
                           theme: theme,
                           name: name,
                           position: Position(row: row, col: col))
        case "CruiseMissile":
            return CruiseMissile(game: game,
                                 player: player,
                                 theme: theme,
                                 name: name,
                                 position: Position(row: row, col: col))
        case "Diplomat":
            return Diplomat(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Engineer":
            return Engineer(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Fanatic":
            return Fanatic(game: game,
                           player: player,
                           theme: theme,
                           name: name,
                           position: Position(row: row, col: col))
        case "Infantry1":
            return Infantry1(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry2":
            return Infantry2(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry3":
            return Infantry3(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry4":
            return Infantry4(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry5":
            return Infantry5(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry6":
            return Infantry6(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry7":
            return Infantry7(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry8":
            return Infantry8(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Marine":
            return Marine(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval1":
            return Naval1(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval2":
            return Naval2(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval3":
            return Naval3(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval4":
            return Naval4(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval5":
            return Naval5(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval6":
            return Naval6(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval7":
            return Naval7(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval8":
            return Naval8(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval9":
            return Naval9(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "NavalTransport":
            return NavalTransport(game: game,
                                  player: player,
                                  theme: theme,
                                  name: name,
                                  position: Position(row: row, col: col))
        case "NuclearMissile":
            return NuclearMissile(game: game,
                                  player: player,
                                  theme: theme,
                                  name: name,
                                  position: Position(row: row, col: col))
        case "ParaTrooper":
            return ParaTrooper(game: game,
                               player: player,
                               theme: theme,
                               name: name,
                               position: Position(row: row, col: col))
        case "Partisan":
            return Partisan(game: game,
                            player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Spy":
            return Spy(game: game,
                       player: player,
                       theme: theme,
                       name: name,
                       position: Position(row: row, col: col))
        case "Submarine":
            return Submarine(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Trade1":
            return Trade1(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Trade2":
            return Trade2(game: game,
                          player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        default:
            return Infantry1(game: game,
                             player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        }
    }
}
