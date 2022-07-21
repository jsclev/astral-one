import Foundation
import SQLite3

public class MoveUnitCommandDAO: BaseDAO {
    private let commandDao: CommandDAO
    
    init(conn: OpaquePointer?, commandDao: CommandDAO) {
        self.commandDao = commandDao
        
        super.init(conn: conn,
                   table: "move_unit_command",
                   loggerName: String(describing: type(of: self)))
    }
    
    public func insert(command: MoveUnitCommand) throws {
        var stmt: OpaquePointer?
        
        let baseCmd = try commandDao.insert(command: Command(player: command.player,
                                                             turn: command.turn,
                                                             ordinal: command.ordinal,
                                                             cost: command.cost))
        let sql = "INSERT INTO move_unit_command (" +
        "command_id, unit_id, from_row, from_col, to_row, to_col) VALUES (?, ?, ?, ?, ?, ?)"
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            // TODO Need to fix the truncation of the Int id
            guard sqlite3_bind_int(stmt, 1, Int32(baseCmd.commandId)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind command_id")
            }
            
            guard sqlite3_bind_int(stmt, 2, Int32(command.unit.id)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind unit_id")
            }
            
            guard sqlite3_bind_int(stmt, 3, Int32(command.unit.position.row)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind from_row")
            }
            
            guard sqlite3_bind_int(stmt, 4, Int32(command.unit.position.col)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind from_col")
            }
            
            guard sqlite3_bind_int(stmt, 5, Int32(command.to.row)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind to_row")
            }
            
            guard sqlite3_bind_int(stmt, 6, Int32(command.to.col)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind to_col")
            }

        } else {
            let sqliteMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(stmt)
            
            var errMsg = "Failed to prepare the statement \"" + sql + "\".  "
            errMsg += "SQLite error message: " + sqliteMsg
            throw DbError.Db(message: errMsg)
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            print("Could not insert row into \(table).")
        }
        
        sqlite3_finalize(stmt)
    }
}
