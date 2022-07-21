import Foundation
import SQLite3

public class PlayerDAO: BaseDAO {
    private let mapDao: MapDAO
    private let unitDao: UnitDAO
    
    init(conn: OpaquePointer?, mapDao: MapDAO, unitDao: UnitDAO) {
        self.mapDao = mapDao
        self.unitDao = unitDao
        
        super.init(conn: conn, table: "player", loggerName: String(describing: type(of: self)))
    }
    
    public func getPlayers(gameId: Int) throws -> [Player] {
        var players: [Player] = []
        let map = try mapDao.get(gameId: gameId)
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                player_id,
                ordinal,
                name,
                skill_level
            FROM
                player
            WHERE
                game_id = \(gameId)
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let playerId = getInt(stmt: stmt, colIndex: 0)
                let ordinal = getInt(stmt: stmt, colIndex: 1)
                let dbSkillLevel = getInt(stmt: stmt, colIndex: 3)
                
                if let name = try getString(stmt: stmt, colIndex: 2) {
                    var skillLevel = SkillLevel.One
                    
                    if dbSkillLevel == 1 {
                        skillLevel = SkillLevel.One
                    }
                    else if dbSkillLevel == 2 {
                        skillLevel = SkillLevel.Two
                    }
                    else if dbSkillLevel == 3 {
                        skillLevel = SkillLevel.Three
                    }
                    else if dbSkillLevel == 4 {
                        skillLevel = SkillLevel.Four
                    }
                    else if dbSkillLevel == 5 {
                        skillLevel = SkillLevel.Five
                    }
                    else if dbSkillLevel == 6 {
                        skillLevel = SkillLevel.Six
                    }
                    else if dbSkillLevel == 7 {
                        skillLevel = SkillLevel.Seven
                    }
                    else if dbSkillLevel == 8 {
                        skillLevel = SkillLevel.Eight
                    }
                    
                    let player = Player(playerId: playerId,
                                        type: PlayerType.AI,
                                        name: name,
                                        ordinal: ordinal,
                                        map: map,
                                        skillLevel: skillLevel,
                                        difficultyLevel: DifficultyLevel.Easy,
                                        strategy: AIStrategy(offense: 0.5,
                                                             defense: 0.5,
                                                             cityQuantity: 0.85))
                    let units = try unitDao.getUnits(player: player)
                    for unit in units {
                        player.add(unit: unit)
                    }
                    
                    players.append(player)
                }
                else {
                    fatalError("Player name cannot be NULL.")
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        return players
    }
}
