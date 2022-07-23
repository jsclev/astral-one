import Foundation
import SQLite3

public class CityNameDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn,
                   table: "city_name",
                   loggerName: String(describing: type(of: self)))
    }
    
    public func getCityNames(civilizationId: Int) throws -> [String] {
        var names: [String] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                name
            FROM
                city_name
            WHERE
                civilization_id = \(civilizationId)
            ORDER BY
                ordinal
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                if let name = try getString(stmt: stmt, colIndex: 0) {
                    names.append(name)
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        return names
    }
}
