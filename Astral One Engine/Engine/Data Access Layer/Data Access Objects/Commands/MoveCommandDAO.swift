import Foundation
import SQLite3

public class MoveCommandDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "move_command", loggerName: String(describing: type(of: self)))
    }
    
//    public func insert(moveCommand: MoveCommand) throws -> MoveCommand {
//        let theme = Theme(id: 1, name: "Standard")
//        let map = Map(mapId: 1, width: 1, height: 1)
//        let game = Game(theme: theme, map: map)
//        let player = Player(playerId: 1, game: game)
//
//        var sql = "INSERT INTO move_command (" +
//        "command_id, unit_id, from_position, to_position)" +
//        ") VALUES "
//
//        sql += "("
//        sql += getSql(val: moveCommand.commandId, postfix: ", ")
//        sql += getSql(val: 1, postfix: ", ")
//        sql += getSql(val: 1, postfix: ", ")
//        sql += getSql(val: 1, postfix: "")
//        sql += "), "
//
//        sql = getCleanedSql(sql)
//
//        do {
//            try executeInsert(table: table, numRows: 1, sql: sql)
//        }
//        catch SQLiteError.Prepare(let message) {
//            var errMsg = "Failed to compile the SQL to insert rows into the \(table) table.  "
//            errMsg += "SQLite error message: " + message
//            throw DbError.Db(message: errMsg)
//        }
//        catch SQLiteError.Step(let message) {
//            var errMsg = "Failed to execute the SQL to insert rows into the \(table) table.  "
//            errMsg += "SQLite error message: " + message
//            throw DbError.Db(message: errMsg)
//        }
//        let turn = Turn(id: 1,
//                        year: -4000,
//                        ordinal: 0,
//                        displayText: "4000 BCE")
//        let commandType = CommandType(id: 1,
//                                      name: "Move Unit")
//        return MoveCommand(commandId: 1,
//                           game: game,
//                           turn: turn,
//                           player: moveCommand.player,
//                           type: commandType,
//                           ordinal: 1,
//                           unit: Infantry1(game: game,
//                                           player: player,
//                                           theme: theme,
//                                           name: "Warrior",
//                                           position: Position(row: 0, col: 0)),
//                           to: Position(row: 0, col: 0))
//    }
}
