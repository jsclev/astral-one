import Foundation
import SQLite3

public class GameActionDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "game_action", loggerName: String(describing: type(of: self)))
    }
    
    public func getActions(gameId: Int) -> [Action] {
        var actions: [Action] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                a.id, a.ordinal,
                t.id, t.ordinal, t.year, t.display_text,
                p.id,
                at.id, at.name
            FROM
                action a
            INNER JOIN
                turn t ON t.id = a.turn_id
            INNER JOIN
                player p ON p.id = a.player_id
            INNER JOIN
                action_type at ON at.id = a.action_type_id
            ORDER BY
                t.ordinal, p.ordinal, a.ordinal
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id = getInt(stmt: stmt, colIndex: 0)
                let actionOrdinal = getInt(stmt: stmt, colIndex: 1)
                let turnId = getInt(stmt: stmt, colIndex: 2)
                let turnOrdinal = getInt(stmt: stmt, colIndex: 3)
                let year = getInt(stmt: stmt, colIndex: 4)
                let gamePlayerId = getInt(stmt: stmt, colIndex: 6)
                let actionTypeId = getInt(stmt: stmt, colIndex: 7)
                
                do {
                    if let turnDisplayText = try getString(stmt: stmt, colIndex: 5),
                       let actionName = try getString(stmt: stmt, colIndex: 8 ) {
                        actions.append(Action(id: id,
                                              gameId: gameId,
                                              turn: Turn(id: turnId,
                                                         year: year,
                                                         ordinal: turnOrdinal,
                                                         displayText: turnDisplayText),
                                              gamePlayerId: gamePlayerId,
                                              actionType: ActionType(id: actionTypeId,
                                                                     name: actionName),
                                              ordinal: actionOrdinal))
                    }
                }
                catch {
                    print(error)
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        return actions
    }
}
