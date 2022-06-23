import Foundation
import SQLite3

public class TurnDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "turn", loggerName: String(describing: type(of: self)))
    }
    
    public func getTurns(theme: Theme) throws -> [Turn] {
        var turns: [Turn] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                turn.turn_id,
                turn.ordinal,
                turn.year,
                turn.display_text,
                theme.theme_id,
                theme.name
            FROM
                turn
            INNER JOIN
                theme ON turn.theme_id = theme.theme_id
            WHERE
                theme.theme_id = \(theme.id)
            ORDER BY
                turn.ordinal
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let turnId = getInt(stmt: stmt, colIndex: 0)
                let turnOrdinal = getInt(stmt: stmt, colIndex: 1)
                let turnYear = getInt(stmt: stmt, colIndex: 2)

                if let turnDisplayText = try getString(stmt: stmt, colIndex: 3) {
                    turns.append(Turn(id: turnId,
                                      year: turnYear,
                                      ordinal: turnOrdinal,
                                      displayText: turnDisplayText))
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        return turns
    }
}
