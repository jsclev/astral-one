import Foundation
import SQLite3

public class ResearchAdvanceCommandDAO: BaseDAO {
    private let commandDao: CommandDAO
    
    init(conn: OpaquePointer?, commandDao: CommandDAO) {
        self.commandDao = commandDao
        
        super.init(conn: conn,
                   table: "research_advance_command",
                   loggerName: String(describing: type(of: self)))
    }
    
    public func insert(command: ResearchAdvanceCommand) throws {
        var stmt: OpaquePointer?
        
        let baseCmd = try commandDao.insert(command: Command(player: command.player,
                                                             turn: command.turn,
                                                             ordinal: command.ordinal,
                                                             cost: command.cost))
        let sql = "INSERT INTO research_advance_command (command_id, advance_id) VALUES (?, ?)"
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            // TODO Need to fix the truncation of the Int id
            guard sqlite3_bind_int(stmt, 1, Int32(baseCmd.commandId)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind")
            }
            
            let advanceId = 1
            guard sqlite3_bind_int(stmt, 2, Int32(advanceId)) == SQLITE_OK else {
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
