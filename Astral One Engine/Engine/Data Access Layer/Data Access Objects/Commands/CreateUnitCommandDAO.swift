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
        var unitId = Constants.noId
        
        if let settler = command.settler {
            let _ = try commandDao.insert(command: Command(player: command.player,
                                                           type: command.type,
                                                           turn: command.turn,
                                                           ordinal: command.ordinal,
                                                           cost: command.cost))
            return try unitDao.insert(settler: settler)
        }
        
        return Settler(unitId: Constants.noId,
                       game: command.player.game,
                       player: command.player,
                       theme: Theme(id: Constants.noId, name: "Standard"),
                       name: "Settler",
                       position: Position.zero)
    }
    
    public func insert(command: CreateEngineerCommand) throws -> Engineer {
        if let engineer = command.engineer {
            let _ = try commandDao.insert(command: Command(player: command.player,
                                                           type: command.type,
                                                           turn: command.turn,
                                                           ordinal: command.ordinal,
                                                           cost: command.cost))
            let persisted = try unitDao.insert(engineer: engineer)
            
            return Engineer(unitId: persisted.id,
                            game: engineer.game,
                            player: engineer.player,
                            theme: engineer.theme,
                            name: engineer.name,
                            position: engineer.position)
            
            
        }
        
        return Engineer(unitId: Constants.noId,
                        game: command.player.game,
                        player: command.player,
                        theme: Theme(id: Constants.noId, name: "Standard"),
                        name: "Engineer",
                        position: Position.zero)
    }
    
}
