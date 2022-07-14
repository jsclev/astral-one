import Foundation
import SQLite3

public class CommandDAO: BaseDAO {
    private let cityDao: CityDAO
    
    init(conn: OpaquePointer?, cityDao: CityDAO) {
        self.cityDao = cityDao
        
        super.init(conn: conn, table: "command", loggerName: String(describing: type(of: self)))
    }
    
    public func getCommands(player: Player) -> [Command] {
        var cmds: [Command] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                c.command_id,
                c.ordinal,
                t.turn_id,
                t.ordinal,
                t.year,
                t.display_text,
                p.player_id,
                cuc.command_id AS cuc_command_id,
                cuc_unit.unit_id AS cuc_unit_id,
                cuc_tile.tile_id AS cuc_tile_id,
                cuc_tile.row AS cuc_row,
                cuc_tile.col AS cuc_col,
                muc.command_id AS muc_command_id,
                muc.unit_id AS muc_unit_id
            FROM
                command c
            INNER JOIN
                turn t ON t.turn_id = c.turn_id
            INNER JOIN
                player p ON p.player_id = c.player_id
            LEFT OUTER JOIN
                create_unit_command cuc ON cuc.command_id = c.command_id
            LEFT OUTER JOIN
                unit cuc_unit ON cuc_unit.unit_id = cuc.unit_id
            LEFT OUTER JOIN
                unit_type cuc_unit_type ON cuc_unit_type.unit_type_id = cuc_unit.unit_type_id
            LEFT OUTER JOIN
                tile cuc_tile ON cuc_tile.tile_id = cuc.tile_id
            LEFT OUTER JOIN
                move_unit_command muc ON muc.command_id = c.command_id
            LEFT OUTER JOIN
                unit muc_unit ON muc_unit.unit_id = muc.unit_id
            WHERE
                c.player_id = \(player.playerId)
            ORDER BY
                t.ordinal, p.ordinal, c.ordinal
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let cmdId = getInt(stmt: stmt, colIndex: 0)
                let cmdOrdinal = getInt(stmt: stmt, colIndex: 1)
                let turnId = getInt(stmt: stmt, colIndex: 2)
                let turnOrdinal = getInt(stmt: stmt, colIndex: 3)
                let year = getInt(stmt: stmt, colIndex: 4)
                let playerId = getInt(stmt: stmt, colIndex: 6)
                
                for gamePlayer in player.game.players {
                    if gamePlayer.playerId == playerId {
                        do {
                            if let turnDisplayText = try getString(stmt: stmt, colIndex: 5) {
                                let turn = Turn(id: turnId,
                                                year: year,
                                                ordinal: turnOrdinal,
                                                displayText: turnDisplayText)
                                
                                if !isNull(stmt, 7) {
                                    let unitId = getInt(stmt: stmt, colIndex: 8)
                                    // let createUnitCmdTileId = getInt(stmt: stmt, colIndex: 9)
                                    let row = getInt(stmt: stmt, colIndex: 10)
                                    let col = getInt(stmt: stmt, colIndex: 11)
                                    let tile = player.map.tile(at: Position(row: row, col: col))

                                    cmds.append(CreateSettlerCommand(commandId: cmdId,
                                                                     player: player,
                                                                     turn: turn,
                                                                     ordinal: cmdOrdinal,
                                                                     cost: 1,
                                                                     settler: Settler(id: unitId,
                                                                                      game: player.game,
                                                                                      player: player,
                                                                                      theme: player.game.theme,
                                                                                      name: "Settler",
                                                                                      position: tile.position),
                                                                     tile: tile))
                                    
                                }
                                else if !isNull(stmt, 12) {
                                    let unitId = getInt(stmt: stmt, colIndex: 13)
                                    // let createUnitCmdTileId = getInt(stmt: stmt, colIndex: 9)
                                    let row = 0 //getInt(stmt: stmt, colIndex: 10)
                                    let col = 0 //getInt(stmt: stmt, colIndex: 11)
                                    
                                    for unit in player.units {
                                        if unit.id == unitId {
                                            cmds.append(MoveUnitCommand(commandId: cmdId,
                                                                        player: player,
                                                                        turn: turn,
                                                                        ordinal: cmdOrdinal,
                                                                        unit: unit,
                                                                        to: Position(row: row, col: col)))
                                        }
                                    }
                                }
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                }

            }
        }
        
        sqlite3_finalize(stmt)
        
        return cmds
    }
    
    public func insert(command: Command) throws -> Command {
        var commandId: Int = -1
        var mainStmt: OpaquePointer?
        var rowIdStmt: OpaquePointer?

        let sql = "INSERT INTO command (player_id, turn_id, ordinal) VALUES (?, ?, ?)"
        let rowIdSql = "SELECT last_insert_rowid()"
        let playerId = Int32(command.player.playerId)
        let turnId = Int32(command.turn.id)
        let ordinal = Int32(command.ordinal)
        
        if sqlite3_prepare_v2(conn, sql, -1, &mainStmt, nil) == SQLITE_OK {
            // TODO Need to fix the truncation of the Int id
            guard sqlite3_bind_int(mainStmt, 1, playerId) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind player_id")
            }
            
            guard sqlite3_bind_int(mainStmt, 2, turnId) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind turn_id")
            }
            
            guard sqlite3_bind_int(mainStmt, 3, ordinal) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind command ordinal")
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
                commandId = getInt(stmt: rowIdStmt, colIndex: 0)
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
        
        return Command(commandId: commandId,
                       player: command.player,
                       turn: command.turn,
                       ordinal: command.ordinal,
                       cost: command.cost)
    }
    
    //    public func insertMoveCommands(moveCommands: [MoveCommand]) throws -> [MoveCommand] {
    //        var newCommands: [MoveCommand] = []
    //        var commandId = -1
    //        var cmdStmt: OpaquePointer?
    //        var rowIdStmt: OpaquePointer?
    //
    //        let theme = Theme(id: 1, name: "Standard")
    //        let map = Map(mapId: 1, width: 1, height: 1)
    //        let game = Game(theme: theme, map: map)
    //        let player = Player(playerId: 1, game: game)
    //
    //        let cmdSql = "INSERT INTO command (" +
    //        "game_id, turn_id, player_id, ordinal" +
    //        ") VALUES (?, ?, ?, ?, ?);"
    //        let rowIdSql = "SELECT last_insert_rowid()"
    //
    //        if sqlite3_exec(conn, "BEGIN TRANSACTION", nil, nil, nil) != SQLITE_OK {
    //            let errMsg = String(cString: sqlite3_errmsg(conn)!)
    //            sqlite3_finalize(rowIdStmt)
    //
    //            throw SQLiteError.Prepare(message: errMsg)
    //        }
    //
    //        if sqlite3_prepare_v2(conn, rowIdSql, -1, &rowIdStmt, nil) != SQLITE_OK {
    //            let errMsg = String(cString: sqlite3_errmsg(conn)!)
    //            sqlite3_finalize(rowIdStmt)
    //
    //            throw SQLiteError.Prepare(message: errMsg)
    //        }
    //
    //        if sqlite3_prepare_v2(conn, cmdSql, -1, &cmdStmt, nil) != SQLITE_OK {
    //            let errMsg = String(cString: sqlite3_errmsg(conn)!)
    //            sqlite3_finalize(rowIdStmt)
    //
    //            throw SQLiteError.Prepare(message: errMsg)
    //        }
    //
    //        for moveCommand in moveCommands {
    //            sqlite3_bind_int(cmdStmt, 1, Int32(1))
    //            sqlite3_bind_int(cmdStmt, 2, Int32(moveCommand.turn.id))
    //            sqlite3_bind_int(cmdStmt, 3, Int32(moveCommand.player.playerId))
    //            sqlite3_bind_int(cmdStmt, 4, Int32(moveCommand.type.id))
    //            sqlite3_bind_int(cmdStmt, 5, Int32(moveCommand.ordinal))
    //
    //            if sqlite3_step(cmdStmt) == SQLITE_DONE {
    //                if sqlite3_step(rowIdStmt) == SQLITE_ROW {
    //                    commandId = getInt(stmt: rowIdStmt, colIndex: 0)
    //                    newCommands.append(MoveCommand(commandId: commandId,
    //                                                   game: game,
    //                                                   turn: moveCommand.turn,
    //                                                   player: moveCommand.player,
    //                                                   type: moveCommand.type,
    //                                                   ordinal: moveCommand.ordinal,
    //                                                   unit: moveCommand.unit,
    //                                                   to: moveCommand.to))
    //                }
    //                else {
    //                    let errMsg = String(cString: sqlite3_errmsg(conn)!)
    //                    sqlite3_finalize(rowIdStmt)
    //
    //                    throw SQLiteError.Step(message: errMsg)
    //                }
    //            }
    //            else {
    //                print("\nCould not insert row.")
    //            }
    //
    //            sqlite3_reset(cmdStmt)
    //            sqlite3_reset(rowIdStmt)
    //        }
    //
    //        sqlite3_finalize(cmdStmt)
    //
    //        if sqlite3_exec (conn, "COMMIT TRANSACTION", nil, nil, nil) != SQLITE_OK {
    //            print ( "Error!!!!" )
    //        }
    //
    //        return newCommands
    
    //        var moveCommandId: Int = -1
    //
    //        var command = try insertCommand(command: Command(commandId: moveCommand.commandId,
    //                                                         gameId: moveCommand.gameId,
    //                                                         turn: moveCommand.turn,
    //                                                         playerId: moveCommand.playerId,
    //                                                         type: moveCommand.type,
    //                                                         ordinal: moveCommand.ordinal))
    //
    //        var sql = "INSERT INTO move_command " +
    //        "(command_id, unit_id, from_position, to_position)" +
    //        " VALUES "
    //
    //        sql += "("
    //        sql += getSql(val: moveCommand.commandId, postfix: ", ")
    //        sql += getSql(val: 1, postfix: ", ")
    //        sql += getSql(val: 1, postfix: ", ")
    //        sql += getSql(val: 1, postfix: "")
    //        sql += "), "
    //
    //        sql = getCleanedSql(sql)
    //
    //        do {
    //            moveCommandId = try insertOneRow(sql: sql)
    //        }
    //        catch SQLiteError.Prepare(let message) {
    //            var errMsg = "Failed to compile the SQL to insert rows into the \(table) table.  "
    //            errMsg += "SQLite error message: " + message
    //            throw DbError.Db(message: errMsg)
    //        }
    //        catch SQLiteError.Step(let message) {
    //            var errMsg = "Failed to execute the SQL to insert rows into the \(table) table.  "
    //            errMsg += "SQLite error message: " + message
    //            throw DbError.Db(message: errMsg)
    //        }
    
    //        return MoveCommand(commandId: 0,
    //                           gameId: moveCommand.gameId,
    //                           turn: moveCommand.turn,
    //                           playerId: moveCommand.playerId,
    //                           type: moveCommand.type,
    //                           ordinal: moveCommand.ordinal,
    //                           unit: Unit(name: "Settler", maxHP: 10),
    //                           toPosition: "Hello")
    //    }
    
    //    func bulkInsert(values: String, objectID: String) -> Bool {
    //        let fileUrl = //your file path to your DB
    //
    //        //open our database
    //        if sqlite3_open(fileUrl.path, &amp;amp;amp;db) != SQLITE_OK {
    //        }
    //        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    //
    //        // convert our JSON string into an object
    //        let fieldStringData = fieldString.data(using: .utf8, allowLossyConversion: false)
    //        let objectID = String(objectID)
    //        let data = values.data(using: .utf8, allowLossyConversion: false)
    //
    //        if let json = try? JSON(data: data!)
    //        {
    //
    //            var compiledStatement: OpaquePointer?
    //            //Start our transaction
    //            sqlite3_exec(conn, "BEGIN IMMEDIATE TRANSACTION", nil, nil, nil)
    //            var query = "INSERT OR REPLACE INTO coffee_shops VALUES (?, ?, ?, ?);";
    //
    //            let rowObjects = json[objectID]
    //
    //            if(sqlite3_prepare_v2(conn, query, -1, &amp;amp;amp;compiledStatement, nil) == SQLITE_OK) {
    //                for (index, obj) in rowObjects
    //                {
    //
    //                    sqlite3_bind_int(compiledStatement, Int32(1),
    //                                     Int32(obj[&amp;quot;id&amp;quot;].stringValue)!);
    //                    sqlite3_bind_text(compiledStatement, Int32(2),
    //                                      obj[&amp;quot;name&amp;quot;].stringValue, -1, SQLITE_TRANSIENT);
    //                    sqlite3_bind_text(compiledStatement, Int32(3),
    //                                      obj[&amp;quot;address&amp;quot;].stringValue, -1, SQLITE_TRANSIENT);
    //                    sqlite3_bind_text(compiledStatement, Int32(4),
    //                                      obj[&amp;quot;price_range&amp;quot;].stringValue, -1, SQLITE_TRANSIENT);
    //
    //                    if (sqlite3_step(compiledStatement) != SQLITE_DONE)
    //                    {
    //                        NSLog(&amp;quot;%s&amp;quot;,sqlite3_errmsg(db));
    //                    }
    //
    //                    if (sqlite3_reset(compiledStatement) != SQLITE_OK)
    //                    {
    //                        NSLog(&amp;quot;%s&amp;quot;,sqlite3_errmsg(db));
    //                    }
    //                }
    //            }
    //
    //            if (sqlite3_finalize(compiledStatement) != SQLITE_OK) {
    //                NSLog("%s", sqlite3_errmsg(conn));
    //            }
    //
    //            if (sqlite3_exec(conn, "COMMIT TRANSACTION", nil, nil, nil) != SQLITE_OK) {
    //                NSLog("%s",sqlite3_errmsg(conn));
    //            }
    //        }
    //
    //        if sqlite3_close_v2(conn) != SQLITE_OK {
    //            print("error closing the database")
    //        }
    //        return true
    //    }
    //    //Close our DB
    //    if sqlite3_close_v2(conn) != SQLITE_OK {
    //        print("error closing the database")
    //    }
    //    return false
    //
    //}
}
