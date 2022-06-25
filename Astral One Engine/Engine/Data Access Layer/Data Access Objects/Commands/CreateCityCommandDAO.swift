import Foundation
import SQLite3

public class CreateCityCommandDAO: BaseDAO {
    private let commandDao: CommandDAO
    private let cityDao: CityDAO
    
    init(conn: OpaquePointer?, commandDao: CommandDAO, cityDao: CityDAO) {
        self.commandDao = commandDao
        self.cityDao = cityDao
        
        super.init(conn: conn, table: "command", loggerName: String(describing: type(of: self)))
    }
    
    public func insert(command: CreateCityCommand) throws -> City {
        let baseCmd = try commandDao.insert(command: Command(player: command.player,
                                                             type: command.type,
                                                             turn: command.turn,
                                                             ordinal: command.ordinal,
                                                             cost: command.cost))
        let city = try cityDao.add(city: command.city!)
        
        var createCitySql = "INSERT INTO create_city_command (" +
        "command_id, unit_id, city_id" +
        ") VALUES "
        
        createCitySql += "("
        createCitySql += getSql(val: baseCmd.commandId, postfix: ", ")
        createCitySql += getSql(val: command.cityCreator.id, postfix: ", ")
        createCitySql += getSql(val: city.id, postfix: "")
        createCitySql += "), "
        
        createCitySql = getCleanedSql(createCitySql)
        
        do {
            let _ = try insertOneRow(sql: createCitySql)
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
        
//        return CreateCityCommand(commandId: baseCmd.commandId,
//                                 player: command.player,
//                                 type: command.type,
//                                 turn: command.turn,
//                                 ordinal: command.ordinal,
//                                 cost: command.cost,
//                                 cityCreator: CityCreator(game: command.player.game,
//                                                          player: command.player,
//                                                          theme: command.player.game.theme,
//                                                          tiledId: Constants.noId,
//                                                          name: "City Builder",
//                                                          assetName: "",
//                                                          cost: 0.0,
//                                                          maxHp: 0.0,
//                                                          attack: 0.0,
//                                                          defense: 0.0,
//                                                          fp: 0.0,
//                                                          maxMovementPoints: 0.0,
//                                                          position: city.position),
//                                 cityName: "Unknown City Name")
        return city
    }
    
}
