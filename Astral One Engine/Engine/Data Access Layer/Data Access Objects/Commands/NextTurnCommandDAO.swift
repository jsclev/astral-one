import Foundation
import SQLite3

public class EndPlayerTurnCommandDAO: BaseDAO {
    private let commandDao: CommandDAO
    
    init(conn: OpaquePointer?, commandDao: CommandDAO) {
        self.commandDao = commandDao
        
        super.init(conn: conn, table: "next_turn_command", loggerName: String(describing: type(of: self)))
    }
    
    public func insert(command: EndPlayerTurnCommand) throws {
        var stmt: OpaquePointer?

        let baseCmd = try commandDao.insert(command: Command(player: command.player,
                                                             turn: command.turn,
                                                             ordinal: command.ordinal,
                                                             cost: command.cost))
        let sql = "INSERT INTO next_turn_command (command_id, turn_id) VALUES (?, ?)"
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            // TODO Need to fix the truncation of the Int id
            guard sqlite3_bind_int(stmt, 1, Int32(baseCmd.commandId)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind")
            }
            
            let turnId = command.turn.id
            guard sqlite3_bind_int(stmt, 2, Int32(turnId)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind")
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
