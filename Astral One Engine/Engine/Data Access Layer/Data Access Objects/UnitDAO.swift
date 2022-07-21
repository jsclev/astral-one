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
        var rowId: Int = -1
        var mainStmt: OpaquePointer?
        var rowIdStmt: OpaquePointer?
        
        // FIXME: Need to provide correct unit type id
        let sql = "INSERT INTO unit (player_id, unit_type_id, tile_id) VALUES (?, ?, ?)"
        let rowIdSql = "SELECT last_insert_rowid()"
        let playerId = Int32(settler.player.playerId)
        let unitTypeId = Int32(Constants.noId)
        let tileId = Int32(settler.player.map.tile(at: settler.position).id)
        
        if sqlite3_prepare_v2(conn, sql, -1, &mainStmt, nil) == SQLITE_OK {
            // TODO Need to fix the truncation of the Int id
            guard sqlite3_bind_int(mainStmt, 1, playerId) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind player_id")
            }
            
            guard sqlite3_bind_int(mainStmt, 2, unitTypeId) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind unit_type_id")
            }
            
            guard sqlite3_bind_int(mainStmt, 3, tileId) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind tile_id")
            }
        } else {
            let sqliteMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(mainStmt)
            
            var errMsg = "Failed to prepare the statement \"" + sql + "\".  "
            errMsg += "SQLite error message: " + sqliteMsg
            throw DbError.Db(message: errMsg)
        }
        
        if sqlite3_prepare_v2(conn, rowIdSql, -1, &rowIdStmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(rowIdStmt)
            
            throw SQLiteError.Prepare(message: errMsg)
        }
        
        if sqlite3_step(mainStmt) == SQLITE_DONE {
            if sqlite3_step(rowIdStmt) == SQLITE_ROW {
                rowId = getInt(stmt: rowIdStmt, colIndex: 0)
            }
            else {
                let errMsg = String(cString: sqlite3_errmsg(conn)!)
                sqlite3_finalize(rowIdStmt)
                
                throw SQLiteError.Step(message: errMsg)
            }
        }
        else {
            let sqliteMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(mainStmt)
            
            let errMsg = "Could not insert row into \(table) table.  " + sqliteMsg
            throw DbError.Db(message: errMsg)
        }
        
        sqlite3_finalize(rowIdStmt)
        sqlite3_finalize(mainStmt)
        
        return Settler(id: rowId,
                       player: settler.player,
                       theme: settler.theme,
                       name: settler.name,
                       position: settler.position)
    }
    
    public func insert(engineer: Engineer) throws -> Engineer {
        var unitId = Constants.noId
        var sql = "INSERT INTO unit (player_id, unit_type_id, tile_id) VALUES "
        
        sql += "("
        sql += getSql(val: engineer.player.playerId, postfix: ", ")
        sql += getSql(val: Constants.noId, postfix: ", ")
        sql += getSql(val: engineer.player.map.tile(at: engineer.position).id, postfix: "")
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
                        player: engineer.player,
                        theme: engineer.theme,
                        name: engineer.name,
                        position: engineer.position)
    }
    
    public func insert(explorer: Explorer) throws -> Explorer {
        var unitId = Constants.noId
        var sql = "INSERT INTO unit (player_id, unit_type_id, tile_id) VALUES "
        
        // FIXME: Need to fix the unit_type_id here
        sql += "("
        sql += getSql(val: explorer.player.playerId, postfix: ", ")
        sql += getSql(val: Constants.noId, postfix: ", ")
        sql += getSql(val: explorer.player.map.tile(at: explorer.position).id, postfix: "")
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
        
        return Explorer(id: unitId,
                        player: explorer.player,
                        theme: explorer.theme,
                        name: explorer.name,
                        position: explorer.position)
    }
    
    public func insert(infantry1: Infantry1) throws -> Infantry1 {
        var unitId = Constants.noId
        var sql = "INSERT INTO unit (player_id, unit_type_id, tile_id) VALUES "
        
        // FIXME: Need to fix the unit_type_id and tile_id here
        sql += "("
        sql += getSql(val: infantry1.player.playerId, postfix: ", ")
        sql += getSql(val: Constants.noId, postfix: ", ")
        sql += getSql(val: infantry1.player.map.tile(at: infantry1.position).id, postfix: "")
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
        
        return Infantry1(id: unitId,
                         player: infantry1.player,
                         theme: infantry1.theme,
                         name: infantry1.name,
                         position: infantry1.position)
    }
    
    public func insert(infantry2: Infantry2) throws -> Infantry2 {
        var unitId = Constants.noId
        var sql = "INSERT INTO unit (player_id, unit_type_id, tile_id) VALUES "
        
        // FIXME: Need to fix the unit_type_id and tile_id here
        sql += "("
        sql += getSql(val: infantry2.player.playerId, postfix: ", ")
        sql += getSql(val: Constants.noId, postfix: ", ")
        sql += getSql(val: infantry2.player.map.tile(at: infantry2.position).id, postfix: "")
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
        
        return Infantry2(id: unitId,
                         player: infantry2.player,
                         theme: infantry2.theme,
                         name: infantry2.name,
                         position: infantry2.position)
    }
    
    public func insert(infantry3: Infantry3) throws -> Infantry3 {
        var unitId = Constants.noId
        var sql = "INSERT INTO unit (player_id, unit_type_id, tile_id) VALUES "
        
        // FIXME: Need to fix the unit_type_id and tile_id here
        sql += "("
        sql += getSql(val: infantry3.player.playerId, postfix: ", ")
        sql += getSql(val: Constants.noId, postfix: ", ")
        sql += getSql(val: infantry3.player.map.tile(at: infantry3.position).id, postfix: "")
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
        
        return Infantry3(id: unitId,
                         player: infantry3.player,
                         theme: infantry3.theme,
                         name: infantry3.name,
                         position: infantry3.position)
    }
    
    public func insert(infantry4: Infantry4) throws -> Infantry4 {
        var unitId = Constants.noId
        var sql = "INSERT INTO unit (player_id, unit_type_id, tile_id) VALUES "
        
        // FIXME: Need to fix the unit_type_id here
        sql += "("
        sql += getSql(val: infantry4.player.playerId, postfix: ", ")
        sql += getSql(val: Constants.noId, postfix: ", ")
        sql += getSql(val: infantry4.player.map.tile(at: infantry4.position).id, postfix: "")
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
        
        return Infantry4(id: unitId,
                         player: infantry4.player,
                         theme: infantry4.theme,
                         name: infantry4.name,
                         position: infantry4.position)
    }
    
    public func getUnits(player: Player) throws -> [Unit] {
        var units: [Unit] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                unit.unit_id,
                unit.player_id,
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
                unit.player_id = \(player.playerId)
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
                    units.append(getUnit(theme: theme,
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
    
    private func getUnit(theme: Theme,
                         typeName: String,
                         name: String,
                         row: Int,
                         col: Int) -> Unit {
        let map = Map(mapId: 1, width: 1, height: 1)
        let player = Player(playerId: 1,
                            type: PlayerType.AI,
                            name: "",
                            ordinal: 1,
                            map: map,
                            skillLevel: SkillLevel.One,
                            difficultyLevel: DifficultyLevel.Easy,
                            strategy: AIStrategy())
        
        switch typeName {
        case "Air1":
            return Air1(player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "Air2":
            return Air2(player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "Air3":
            return Air3(player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "Air4":
            return Air4(player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "Air5":
            return Air5(player: player,
                        theme: theme,
                        name: name,
                        position: Position(row: row, col: col))
        case "AircraftCarrier":
            return AircraftCarrier(player: player,
                                   theme: theme,
                                   name: name,
                                   position: Position(row: row, col: col))
        case "AlpineTroop":
            return AlpineTroop(player: player,
                               theme: theme,
                               name: name,
                               position: Position(row: row, col: col))
        case "Artillery1":
            return Artillery1(player: player,
                              theme: theme,
                              name: name,
                              position: Position(row: row, col: col))
        case "Artillery2":
            return Artillery2(player: player,
                              theme: theme,
                              name: name,
                              position: Position(row: row, col: col))
        case "Artillery3":
            return Artillery3(player: player,
                              theme: theme,
                              name: name,
                              position: Position(row: row, col: col))
        case "Artillery4":
            return Artillery4(player: player,
                              theme: theme,
                              name: name,
                              position: Position(row: row, col: col))
        case "Crusader":
            return Crusader(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry1":
            return Cavalry1(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry2":
            return Cavalry2(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry3":
            return Cavalry3(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry4":
            return Cavalry4(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry5":
            return Cavalry5(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry6":
            return Cavalry6(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry7":
            return Cavalry7(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Cavalry8":
            return Cavalry8(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "CityCreator":
            return Settler(player: player,
                           theme: theme,
                           name: name,
                           position: Position(row: row, col: col))
        case "CruiseMissile":
            return CruiseMissile(player: player,
                                 theme: theme,
                                 name: name,
                                 position: Position(row: row, col: col))
        case "Diplomat":
            return Diplomat(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Engineer":
            return Engineer(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Fanatic":
            return Fanatic(player: player,
                           theme: theme,
                           name: name,
                           position: Position(row: row, col: col))
        case "Infantry1":
            return Infantry1(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry2":
            return Infantry2(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry3":
            return Infantry3(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry4":
            return Infantry4(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry5":
            return Infantry5(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry6":
            return Infantry6(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry7":
            return Infantry7(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Infantry8":
            return Infantry8(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Marine":
            return Marine(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval1":
            return Naval1(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval2":
            return Naval2(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval3":
            return Naval3(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval4":
            return Naval4(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval5":
            return Naval5(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval6":
            return Naval6(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval7":
            return Naval7(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval8":
            return Naval8(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Naval9":
            return Naval9(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "NavalTransport":
            return NavalTransport(player: player,
                                  theme: theme,
                                  name: name,
                                  position: Position(row: row, col: col))
        case "NuclearMissile":
            return NuclearMissile(player: player,
                                  theme: theme,
                                  name: name,
                                  position: Position(row: row, col: col))
        case "ParaTrooper":
            return ParaTrooper(player: player,
                               theme: theme,
                               name: name,
                               position: Position(row: row, col: col))
        case "Partisan":
            return Partisan(player: player,
                            theme: theme,
                            name: name,
                            position: Position(row: row, col: col))
        case "Spy":
            return Spy(player: player,
                       theme: theme,
                       name: name,
                       position: Position(row: row, col: col))
        case "Submarine":
            return Submarine(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        case "Trade1":
            return Trade1(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        case "Trade2":
            return Trade2(player: player,
                          theme: theme,
                          name: name,
                          position: Position(row: row, col: col))
        default:
            return Infantry1(player: player,
                             theme: theme,
                             name: name,
                             position: Position(row: row, col: col))
        }
    }
}
