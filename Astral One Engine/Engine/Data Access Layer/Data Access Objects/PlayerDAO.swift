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
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                p.player_id,
                p.ordinal,
                p.name,
                p.skill_level,
                c.civilization_id,
                c.name,
                c.color
            FROM
                player p
            INNER JOIN
                civilization c ON c.civilization_id = p.civilization_id
            WHERE
                p.game_id = \(gameId)
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                // FIXME: Need to get the player's map from
                //        the datbase, not the game map
                let map = try mapDao.get(gameId: gameId)

                let playerId = getInt(stmt: stmt, colIndex: 0)
                let ordinal = getInt(stmt: stmt, colIndex: 1)
                let dbSkillLevel = getInt(stmt: stmt, colIndex: 3)
                let civilizationId = getInt(stmt: stmt, colIndex: 4)

                if let playerName = try getString(stmt: stmt, colIndex: 2),
                   let civilizationName = try getString(stmt: stmt, colIndex: 5),
                   let civilizationColor = try getString(stmt: stmt, colIndex: 6) {
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
                                        civilization: Civilization(id: civilizationId,
                                                                   name: civilizationName,
                                                                   color: civilizationColor),
                                        name: playerName,
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
