import Foundation
import SQLite3

public class GameDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "game", loggerName: String(describing: type(of: self)))
    }
    
}
