import Foundation
import SQLite3

public class CityDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "city", loggerName: String(describing: type(of: self)))
    }
    
    public func add(city: City) throws -> City {
        return City(id: city.id + 100,
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
                                       owner: Player(playerId: 1, game: game, map: game.map),
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
