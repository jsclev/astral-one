import Foundation
import SQLite3

public class GameDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "game", loggerName: String(describing: type(of: self)))
    }
    
    public func getCurrentUnit() -> Unit {
//        var stmt: OpaquePointer?
//        let sql = """
//            SELECT
//                id,
//                name
//            FROM
//                game
//        """
        
//        if sqlite3_prepare_v2(conn, statSql, -1, &stmt, nil) == SQLITE_OK {
//            while sqlite3_step(stmt) == SQLITE_ROW {
//                let id = getInt(stmt: stmt, colIndex: 0)
//                let workId = getInt(stmt: statStmt, colIndex: 1)
//                let dbReadStatus = getInt(stmt: statStmt, colIndex: 2)
//                let dbOwnStatus = getInt(stmt: statStmt, colIndex: 3)
//            }
//        }
        
        var stmt: OpaquePointer?
        var id = 1
        var unitName: String = ""
        
        do {
            try getRowById(stmt: &stmt, table: table, idName: "id", id: 1)
            
            id = getInt(stmt: stmt, colIndex: 0)
            if let name = try getString(stmt: stmt, colIndex: 1) {
                unitName = name
            }
        }
        catch {
            print(error)
        }
        
        sqlite3_finalize(stmt)
        
        return Unit(name: unitName, maxHP: id)
    }
}
