import Foundation
import SQLite3

public class CreateUnitCommandDAO: BaseDAO {
    private let commandDao: CommandDAO
    private let unitDao: UnitDAO
    
    init(conn: OpaquePointer?, commandDao: CommandDAO, unitDao: UnitDAO) {
        self.commandDao = commandDao
        self.unitDao = unitDao
        
        super.init(conn: conn, table: "command", loggerName: String(describing: type(of: self)))
    }
    
//    public func insert(command: CreateCavalry8Command) throws -> Cavalry8 {
//        let newCommand = try commandDao.insert(command: Command(player: command.player,
//                                                                turn: command.turn,
//                                                                ordinal: command.ordinal,
//                                                                cost: command.cost))
//        let unit = try unitDao.insert(cavalry: command.cavalry)
//        try insert(command: newCommand, unit: unit)
//
//        return unit
//    }
//
//    public func insert(command: CreateCavalry8Command) throws -> Cavalry8 {
//        let newCommand = try commandDao.insert(command: Command(player: command.player,
//                                                                turn: command.turn,
//                                                                ordinal: command.ordinal,
//                                                                cost: command.cost))
//        let unit = try unitDao.insert(cavalry: command.cavalry)
//        try insert(command: newCommand, unit: unit)
//
//        return unit
//    }
//
//    public func insert(command: CreateCavalry8Command) throws -> Cavalry8 {
//        let newCommand = try commandDao.insert(command: Command(player: command.player,
//                                                                turn: command.turn,
//                                                                ordinal: command.ordinal,
//                                                                cost: command.cost))
//        let unit = try unitDao.insert(cavalry: command.cavalry)
//        try insert(command: newCommand, unit: unit)
//
//        return unit
//    }
//
//    public func insert(command: CreateCavalry8Command) throws -> Cavalry8 {
//        let newCommand = try commandDao.insert(command: Command(player: command.player,
//                                                                turn: command.turn,
//                                                                ordinal: command.ordinal,
//                                                                cost: command.cost))
//        let unit = try unitDao.insert(cavalry: command.cavalry)
//        try insert(command: newCommand, unit: unit)
//
//        return unit
//    }
//
//    public func insert(command: CreateCavalry8Command) throws -> Cavalry8 {
//        let newCommand = try commandDao.insert(command: Command(player: command.player,
//                                                                turn: command.turn,
//                                                                ordinal: command.ordinal,
//                                                                cost: command.cost))
//        let unit = try unitDao.insert(cavalry: command.cavalry)
//        try insert(command: newCommand, unit: unit)
//
//        return unit
//    }
//
//    public func insert(command: CreateCavalry8Command) throws -> Cavalry8 {
//        let newCommand = try commandDao.insert(command: Command(player: command.player,
//                                                                turn: command.turn,
//                                                                ordinal: command.ordinal,
//                                                                cost: command.cost))
//        let unit = try unitDao.insert(cavalry: command.cavalry)
//        try insert(command: newCommand, unit: unit)
//
//        return unit
//    }
    
    public func insert(command: CreateCavalry7Command) throws -> Cavalry7 {
        let newCommand = try commandDao.insert(command: Command(player: command.player,
                                                                turn: command.turn,
                                                                ordinal: command.ordinal,
                                                                cost: command.cost))
        let unit = try unitDao.insert(cavalry: command.cavalry)
        try insert(command: newCommand, unit: unit)
        
        return unit
    }
    
    public func insert(command: CreateCavalry8Command) throws -> Cavalry8 {
        let newCommand = try commandDao.insert(command: Command(player: command.player,
                                                                turn: command.turn,
                                                                ordinal: command.ordinal,
                                                                cost: command.cost))
        let unit = try unitDao.insert(cavalry: command.cavalry)
        try insert(command: newCommand, unit: unit)
        
        return unit
    }
    
    public func insert(command: CreateSettlerCommand) throws -> Settler {
        let newCommand = try commandDao.insert(command: Command(player: command.player,
                                                                turn: command.turn,
                                                                ordinal: command.ordinal,
                                                                cost: command.cost))
        let settler = try unitDao.insert(settler: command.settler)
        try insert(command: newCommand, unit: settler)
        
        return settler
    }
    
    public func insert(command: CreateEngineerCommand) throws -> Engineer {
        let _ = try commandDao.insert(command: Command(player: command.player,
                                                       turn: command.turn,
                                                       ordinal: command.ordinal,
                                                       cost: command.cost))
        return try unitDao.insert(engineer: command.engineer)
    }
    
    public func insert(command: CreateExplorerCommand) throws -> Explorer {
        let _ = try commandDao.insert(command: Command(player: command.player,
                                                       turn: command.turn,
                                                       ordinal: command.ordinal,
                                                       cost: command.cost))
        return try unitDao.insert(explorer: command.explorer)
    }
    
    public func insert(command: CreateInfantry1Command) throws -> Infantry1 {
        let _ = try commandDao.insert(command: Command(player: command.player,
                                                       turn: command.turn,
                                                       ordinal: command.ordinal,
                                                       cost: command.cost))
        return try unitDao.insert(infantry1: command.infantry1)
    }
    
    public func insert(command: CreateInfantry2Command) throws -> Infantry2 {
        let _ = try commandDao.insert(command: Command(player: command.player,
                                                       turn: command.turn,
                                                       ordinal: command.ordinal,
                                                       cost: command.cost))
        return try unitDao.insert(infantry2: command.infantry2)
    }
    
    public func insert(command: CreateInfantry3Command) throws -> Infantry3 {
        let _ = try commandDao.insert(command: Command(player: command.player,
                                                       turn: command.turn,
                                                       ordinal: command.ordinal,
                                                       cost: command.cost))
        return try unitDao.insert(infantry3: command.infantry3)
    }
    
    public func insert(command: CreateInfantry4Command) throws -> Infantry4 {
        let _ = try commandDao.insert(command: Command(player: command.player,
                                                       turn: command.turn,
                                                       ordinal: command.ordinal,
                                                       cost: command.cost))
        return try unitDao.insert(infantry4: command.infantry4)
    }
    
    private func insert(command: Command, unit: Unit) throws {
        var sql = "INSERT INTO create_unit_command (command_id, unit_id, tile_id) VALUES "
        sql += "("
        sql += getSql(val: command.commandId, postfix: ", ")
        sql += getSql(val: unit.id, postfix: ", ")
        sql += getSql(val: unit.player.map.tile(at: unit.position).id, postfix: "")
        sql += "), "
        
        sql = getCleanedSql(sql)
        
        do {
            let _ = try insertOneRow(sql: sql)
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
    }
    
}
