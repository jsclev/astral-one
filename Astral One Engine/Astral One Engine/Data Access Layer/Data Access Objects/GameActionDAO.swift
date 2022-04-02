import Foundation
import SQLite3

public class GameActionDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "game_action", loggerName: String(describing: type(of: self)))
    }
    
    public func getActions(gameId: Int) -> [GameAction] {
        var gameActions: [GameAction] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                ga.id,
                ga.turn_id,
                ga.game_player_id,
                ga.action_id,
                ga.ordinal
            FROM
                game_action ga
            INNER JOIN
                turn t ON t.id = ga.turn_id
            ORDER BY
                t.ordinal,
                ga.ordinal
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id = getInt(stmt: stmt, colIndex: 0)
                let turnId = getInt(stmt: stmt, colIndex: 1)
                let gamePlayerId = getInt(stmt: stmt, colIndex: 2)
                let actionId = getInt(stmt: stmt, colIndex: 3)
                let ordinal = getInt(stmt: stmt, colIndex: 4)
                
                gameActions.append(GameAction(id: id,
                                              gameId: gameId,
                                              turnId: turnId,
                                              gamePlayerId: gamePlayerId,
                                              actionId: actionId,
                                              ordinal: ordinal))
            }
        }
        
        sqlite3_finalize(stmt)
        
        return gameActions
    }
}
