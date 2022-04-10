import Foundation
import SQLite3

public class GameDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "game", loggerName: String(describing: type(of: self)))
    }
    
    public func getCurrentUnit() -> Unit {
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
        
        return Unit(playerId: 1, name: unitName, maxHP: id, row: 0, col: 0)
    }
}
