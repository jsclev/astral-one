import Foundation
import SQLite3

public class BuildingTypeDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "building_type", loggerName: String(describing: type(of: self)))
    }
    
    public func getBuildingTypeId(buildingType: BuildingType, theme: Theme) throws -> Int {
        var stmt: OpaquePointer?
        let sql = "SELECT building_type_id FROM \(table) where core_name = ? AND theme_id = ?"
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            guard sqlite3_bind_text(stmt, 1, buildingType.description, -1, SQLITE_TRANSIENT) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind")
            }
            
            guard sqlite3_bind_int(stmt, 2, Int32(theme.id)) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind")
            }
        } else {
            let sqliteMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(stmt)

            var errMsg = "Failed to prepare the statement \"" + sql + "\".  "
            errMsg += "SQLite error message: " + sqliteMsg

            throw DbError.Db(message: errMsg)
        }

        if sqlite3_step(stmt) != SQLITE_ROW {
            throw DbError.Db(message: "Row does not exist.")
        }
        
        let buildingTypeId = getInt(stmt: stmt, colIndex: 0)

        sqlite3_finalize(stmt)

        return buildingTypeId
    }
}
