import Foundation
import SQLite3

public class CityDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "city", loggerName: String(describing: type(of: self)))
    }
    
    public func add(city: City) throws -> City {
        var cityId = Constants.noId
        
        var sql = "INSERT INTO city (game_id, player_id, name, tile_id) VALUES "
        
        sql += "("
        sql += getSql(val: city.owner.game.gameId, postfix: ", ")
        sql += getSql(val: city.owner.playerId, postfix: ", ")
        sql += getSql(val: city.name, postfix: ", ")
        sql += getSql(val: city.owner.map.tile(at: city.position).id, postfix: "")
        sql += "), "
        
        sql = getCleanedSql(sql)
        
        do {
            cityId = try insertOneRow(sql: sql)
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
        
        return City(id: cityId,
                    owner: city.owner,
                    theme: city.theme,
                    name: city.name,
                    assetName: city.assetName,
                    position: city.position)
    }
    
    public func getCities(game: Game) throws -> [City] {
        var cities: [City] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                c.city_id,
                c.game_id,
                c.player_id,
                c.tile_id,
                c.name,
                t.row,
                t.col
            FROM
                city c
            INNER JOIN
                tile t ON t.tile_id = c.tile_id
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let cityId = getInt(stmt: stmt, colIndex: 0)
                let row = getInt(stmt: stmt, colIndex: 5)
                let col = getInt(stmt: stmt, colIndex: 6)
                
                if let cityName = try getString(stmt: stmt, colIndex: 4) {
                    cities.append(City(id: cityId,
                                       owner: Player(playerId: 1, game: game, name: "", map: game.map),
                                       theme: Theme(id: 1, name: "Standard"),
                                       name: cityName,
                                       assetName: "city-1",
                                       position: Position(row: row, col: col)))
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        return cities
    }
}
