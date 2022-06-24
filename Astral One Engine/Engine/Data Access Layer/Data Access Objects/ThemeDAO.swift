import Foundation
import SQLite3

public class ThemeDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "theme", loggerName: String(describing: type(of: self)))
    }
    
    public func getBy(themeId: Int) throws -> Theme {
//        var stmt: OpaquePointer?
//        let sql = "SELECT theme_id, name FROM \(table) where name = '?'"
//
//        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
//            guard (sqlite3_bind_text(stmt, 0, name, -1, nil) != SQLITE_OK) else {
//                throw DbError.Db(message: "Unable to bind name column on \(table) table.")
//            }
//        } else {
//            let sqliteMsg = String(cString: sqlite3_errmsg(conn)!)
//            sqlite3_finalize(stmt)
//
//            var errMsg = "Failed to prepare the statement \"" + sql + "\".  "
//            errMsg += "SQLite error message: " + sqliteMsg
//            throw DbError.Db(message: errMsg)
//        }
//
//        var themeId = Constants.noId
//        var themeName = ""
//
//        if sqlite3_step(stmt) == SQLITE_ROW {
//            themeId = getInt(stmt: stmt, colIndex: 0)
//
//            if let name = try getString(stmt: stmt, colIndex: 1) {
//                themeName = name
//            }
//        }
//        else {
//            throw DbError.Db(message: "Row does not exist.")
//        }
//
//        return Theme(id: themeId, name: themeName)
        
        var stmt: OpaquePointer?
        try getRowById(stmt: &stmt, table: table, idName: "theme_id", id: themeId)
        
        let themeId = getInt(stmt: stmt, colIndex: 0)

        if let themeName = try getString(stmt: stmt, colIndex: 1) {
            sqlite3_finalize(stmt)
            
            return Theme(id: themeId, name: themeName)
        }
        
        throw DbError.Db(message: "Unable to get theme with theme_id = \(themeId).")
    }
}
