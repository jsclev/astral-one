import Foundation
import SQLite3

public class MoveUnitCommandDAO: BaseDAO {
    private let commandDao: CommandDAO
    
    init(conn: OpaquePointer?, commandDao: CommandDAO) {
        self.commandDao = commandDao
        
        super.init(conn: conn, table: "move_unit_command", loggerName: String(describing: type(of: self)))
    }
    
    public func insert(command: MoveUnitCommand) throws {
        let newCommand = try commandDao.insert(command: Command(player: command.player,
                                                                turn: command.turn,
                                                                ordinal: command.ordinal,
                                                                cost: command.cost))
        // FIXME: Should use bind vars for this
        var sql = "INSERT INTO move_unit_command (" +
        "command_id, unit_id, from_row, from_col, to_row, to_col) VALUES "
        
        sql += "("
        sql += getSql(val: newCommand.commandId, postfix: ", ")
        sql += getSql(val: command.unit.id, postfix: ", ")
        sql += getSql(val: command.unit.position.row, postfix: ", ")
        sql += getSql(val: command.unit.position.col, postfix: ", ")
        sql += getSql(val: command.to.row, postfix: ", ")
        sql += getSql(val: command.to.col, postfix: "")
        sql += "), "

        sql = getCleanedSql(sql)

        do {
            try executeInsert(table: table, numRows: 1, sql: sql)
        }
        catch SQLiteError.Prepare(let message) {
            var errMsg = "Failed to compile the SQL to insert rows into the \(table) table.  "
            errMsg += "SQLite error message: " + message
            throw DbError.Db(message: errMsg)
        }
        catch SQLiteError.Step(let message) {
            var errMsg = "Failed to execute the SQL to insert rows into the \(table) table.  "
            errMsg += "SQLite error message: " + message
            throw DbError.Db(message: errMsg)
        }
        let turn = Turn(id: 1,
                        year: -4000,
                        ordinal: 0,
                        displayText: "4000 BCE")
//        return MoveUnitCommand(commandId: 1,
//                               game: command.player.game,
//                           turn: turn,
//                           player: command.player,
//                           ordinal: command.player.game.getCurrentTurn().ordinal,
//                               unit: Infantry1(game: command.player.game,
//                                               player: command.player,
//                                               theme: command.player.game.theme,
//                                           name: "Warrior",
//                                           position: Position(row: 0, col: 0)),
//                           to: Position(row: 0, col: 0))
    }
}
