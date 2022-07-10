import Foundation
import SQLite3

public class BuildBuildingCommandDAO: BaseDAO {
    private let commandDao: CommandDAO
    
    init(conn: OpaquePointer?, commandDao: CommandDAO) {
        self.commandDao = commandDao
        
        super.init(conn: conn, table: "command", loggerName: String(describing: type(of: self)))
    }
    
    public func insert(command: BuildBuildingCommand) throws {
        let baseCmd = try commandDao.insert(command: Command(player: command.player,
                                                             turn: command.turn,
                                                             ordinal: command.ordinal,
                                                             cost: command.cost))
        let buildingTypeId = 1
        
        var sql = "INSERT INTO build_building_command (command_id, city_id, building_type_id) VALUES "
        
        sql += "("
        sql += getSql(val: baseCmd.commandId, postfix: ", ")
        sql += getSql(val: command.city.id, postfix: ", ")
        sql += getSql(val: buildingTypeId, postfix: "")
        sql += "), "
        
        sql = getCleanedSql(sql)
        
        do {
            let _ = try insertOneRow(sql: sql)
        }
        catch SQLiteError.Prepare(let message) {
            var errMsg = "Failed to compile SQL to insert rows into the create_city_command table.  "
            errMsg += "SQLite error message: " + message
            throw DbError.Db(message: errMsg)
        }
        catch SQLiteError.Step(let message) {
            var errMsg = "Failed to execute SQL to insert rows into create_city_command table.  "
            errMsg += "SQLite error message: " + message
            throw DbError.Db(message: errMsg)
        }
    }
    
}
