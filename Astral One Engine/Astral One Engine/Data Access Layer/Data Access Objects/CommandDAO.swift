import Foundation
import SQLite3

public class CommandDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "command", loggerName: String(describing: type(of: self)))
    }
    
    public func getCommands(gameId: Int) -> [Command] {
        var commands: [Command] = []
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                c.id AS command_id, c.ordinal,
                t.id, t.ordinal, t.year, t.display_text,
                p.id,
                ct.id, ct.name,
                mc.id AS mc_id, mc.unit_id AS mc_unit_id, mc.to_position
            FROM
                command c
            INNER JOIN
                turn t ON t.id = c.turn_id
            INNER JOIN
                player p ON p.id = c.player_id
            INNER JOIN
                command_type ct ON ct.id = c.command_type_id
            LEFT OUTER JOIN
                movement_command mc ON mc.command_id = c.id
            LEFT OUTER JOIN
                settle_command sc ON sc.command_id = c.id
            LEFT OUTER JOIN
                tech_command tc ON tc.command_id = c.id
            LEFT OUTER JOIN
                building_command bc ON bc.command_id = c.id
            ORDER BY
                t.ordinal, p.ordinal, c.ordinal
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let commandId = getInt(stmt: stmt, colIndex: 0)
                let commandOrdinal = getInt(stmt: stmt, colIndex: 1)
                let turnId = getInt(stmt: stmt, colIndex: 2)
                let turnOrdinal = getInt(stmt: stmt, colIndex: 3)
                let year = getInt(stmt: stmt, colIndex: 4)
                let playerId = getInt(stmt: stmt, colIndex: 6)
                let commandTypeId = getInt(stmt: stmt, colIndex: 7)
                
                do {
                    if let turnDisplayText = try getString(stmt: stmt, colIndex: 5),
                       let commandName = try getString(stmt: stmt, colIndex: 8 ) {
                        let turn = Turn(id: turnId,
                                        year: year,
                                        ordinal: turnOrdinal,
                                        displayText: turnDisplayText)
                        let commandType = CommandType(id: commandTypeId,
                                                      name: commandName)
                        
                        if commandName == "Move Unit" {
                            commands.append(MoveCommand(commandId: commandId,
                                                        gameId: gameId,
                                                        turn: turn,
                                                        playerId: playerId,
                                                        type: commandType,
                                                        ordinal: commandOrdinal,
                                                        unit: Unit(name: "Settler", maxHP: 10),
                                                        toPosition: "Hello"))
                        }
                        else if commandName == "Research Tech" {
                            commands.append(TechCommand(commandId: commandId,
                                                        gameId: gameId,
                                                        turn: turn,
                                                        playerId: playerId,
                                                        type: commandType,
                                                        ordinal: commandOrdinal,
                                                        unit: Unit(name: "Settler", maxHP: 10),
                                                        toPosition: "Hello"))
                        }
                        else if commandName == "Build Building" {
                            commands.append(BuildBuildingCommand(commandId: commandId,
                                                                 gameId: gameId,
                                                                 turn: turn,
                                                                 playerId: playerId,
                                                                 type: commandType,
                                                                 ordinal: commandOrdinal,
                                                                 unit: Unit(name: "Settler", maxHP: 10),
                                                                 toPosition: "Hello"))
                        }
                        else if commandName == "Build City" {
                            commands.append(BuildCityCommand(commandId: commandId,
                                                             gameId: gameId,
                                                             turn: turn,
                                                             playerId: playerId,
                                                             type: commandType,
                                                             ordinal: commandOrdinal,
                                                             unit: Unit(name: "Settler", maxHP: 10),
                                                             toPosition: "Hello"))
                        }
                    }
                }
                catch {
                    print(error)
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        return commands
    }
}
