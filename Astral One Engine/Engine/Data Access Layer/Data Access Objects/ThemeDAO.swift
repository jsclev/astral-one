import Foundation
import SQLite3

public class ThemeDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "theme", loggerName: String(describing: type(of: self)))
    }
    
    public func getBy(themeId: Int) throws -> Theme {
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
