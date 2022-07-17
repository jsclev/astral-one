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
    
    public func insert(command: CreateSettlerCommand) throws -> Settler {
        if let settler = command.settler {
            let newCommand = try commandDao.insert(command: Command(player: command.player,
                                                                    turn: command.turn,
                                                                    ordinal: command.ordinal,
                                                                    cost: command.cost))
            let newSettler = try unitDao.insert(settler: settler)
            
            try insert(command: newCommand, unit: newSettler)
            
            return newSettler
        }
        
        return Settler(id: Constants.noId,
                       player: command.player,
                       theme: Theme(id: Constants.noId, name: "Standard"),
                       name: "Settler",
                       position: Position.zero)
    }
    
    public func insert(command: CreateEngineerCommand) throws -> Engineer {
        if let engineer = command.engineer {
            let _ = try commandDao.insert(command: Command(player: command.player,
                                                           turn: command.turn,
                                                           ordinal: command.ordinal,
                                                           cost: command.cost))
            return try unitDao.insert(engineer: engineer)
        }
        
        return Engineer(id: Constants.noId,
                        player: command.player,
                        theme: Theme(id: Constants.noId, name: "Standard"),
                        name: "Engineer",
                        position: Position.zero)
    }
    
    public func insert(command: CreateExplorerCommand) throws -> Explorer {
        if let explorer = command.explorer {
            let _ = try commandDao.insert(command: Command(player: command.player,
                                                           turn: command.turn,
                                                           ordinal: command.ordinal,
                                                           cost: command.cost))
            return try unitDao.insert(explorer: explorer)
        }
        
        return Explorer(id: Constants.noId,
                       player: command.player,
                       theme: Theme(id: Constants.noId, name: "Standard"),
                       name: "Explorer",
                       position: Position.zero)
    }
    
    public func insert(command: CreateInfantry1Command) throws -> Infantry1 {
        if let infantry1 = command.infantry1 {
            let _ = try commandDao.insert(command: Command(player: command.player,
                                                           turn: command.turn,
                                                           ordinal: command.ordinal,
                                                           cost: command.cost))
            return try unitDao.insert(infantry1: infantry1)
        }
        
        return Infantry1(id: Constants.noId,
                        player: command.player,
                        theme: Theme(id: Constants.noId, name: "Standard"),
                        name: "Infantry1",
                        position: Position.zero)
    }
    
    public func insert(command: CreateInfantry2Command) throws -> Infantry2 {
        if let infantry2 = command.infantry2 {
            let _ = try commandDao.insert(command: Command(player: command.player,
                                                           turn: command.turn,
                                                           ordinal: command.ordinal,
                                                           cost: command.cost))
            return try unitDao.insert(infantry2: infantry2)
        }
        
        return Infantry2(id: Constants.noId,
                         player: command.player,
                         theme: Theme(id: Constants.noId, name: "Standard"),
                         name: "Infantry2",
                         position: Position.zero)
    }
    
    public func insert(command: CreateInfantry3Command) throws -> Infantry3 {
        if let infantry3 = command.infantry3 {
            let _ = try commandDao.insert(command: Command(player: command.player,
                                                           turn: command.turn,
                                                           ordinal: command.ordinal,
                                                           cost: command.cost))
            return try unitDao.insert(infantry3: infantry3)
        }
        
        return Infantry3(id: Constants.noId,
                         player: command.player,
                         theme: Theme(id: Constants.noId, name: "Standard"),
                         name: "Infantry3",
                         position: Position.zero)
    }
    
    public func insert(command: CreateInfantry4Command) throws -> Infantry4 {
        if let infantry4 = command.infantry4 {
            let _ = try commandDao.insert(command: Command(player: command.player,
                                                           turn: command.turn,
                                                           ordinal: command.ordinal,
                                                           cost: command.cost))
            return try unitDao.insert(infantry4: infantry4)
        }
        
        return Infantry4(id: Constants.noId,
                         player: command.player,
                         theme: Theme(id: Constants.noId, name: "Standard"),
                         name: "Infantry4",
                         position: Position.zero)
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
