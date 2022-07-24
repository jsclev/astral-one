import Foundation
import SQLite3

public class SkinDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "skin", loggerName: String(describing: type(of: self)))
    }
    
    public func getSkins() throws -> [UnitType: Skin] {
        var stmt: OpaquePointer?

        let sql = """
                      SELECT
        ut.unit_type_id,
                          s.skin_id,
                          s.name
                      FROM
                          unit_type ut
                      INNER JOIN
                          skin s ON s.skin_id = ut.skin_id
                      WHERE
                          ut.name = ?
        """
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let cityId = getInt(stmt: stmt, colIndex: 0)
            let row = getInt(stmt: stmt, colIndex: 5)
            let col = getInt(stmt: stmt, colIndex: 6)
            
            if let cityName = try getString(stmt: stmt, colIndex: 4) {
                cities.append(City(id: cityId,
                                   owner: player,
                                   name: cityName,
                                   theme: theme,
                                   assetName: "city-1",
                                   position: Position(row: row, col: col)))
            }
        }
    }
    
    public func getSkinBy(unitType: UnitType) -> Skin {
        var skinId: Int = Constants.noId
        var skinName = Constants.defaultSkinName
        var stmt: OpaquePointer?
        
        let sql = """
                      SELECT
                          s.skin_id,
                          s.name
                      FROM
                          unit_type ut
                      INNER JOIN
                          skin s ON s.skin_id = ut.skin_id
                      WHERE
                          ut.name = ?
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            // TODO Need to fix the truncation of the Int id
            guard sqlite3_bind_text(stmt, 1, unitType.description, -1, SQLITE_TRANSIENT) == SQLITE_OK else {
                throw DbError.Db(message: "Unable to bind")
            }
            
        } else {
            let sqliteMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(stmt)
            
            var errMsg = "Failed to prepare the statement \"" + sql + "\".  "
            errMsg += "SQLite error message: " + sqliteMsg
            throw DbError.Db(message: errMsg)
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            skinId = getInt(stmt: stmt, colIndex: 0)

            if let name = try getString(stmt: stmt, colIndex: 1) {
                skinName = name
            }
        }
        else {
            let sqliteMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(stmt)
            
            let errMsg = "Could not insert row into \(table) table.  " + sqliteMsg
            throw DbError.Db(message: errMsg)
        }
        
        sqlite3_finalize(stmt)
        
        return Skin(id: skinId, name: skinName)
    }
}
