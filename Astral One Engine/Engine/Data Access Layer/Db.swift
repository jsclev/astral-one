import Foundation
import os
import SQLite3

public class Db {
    //    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Db")
    var dbPointer: OpaquePointer?
    let dbFilename = "civitas"
    let dbExtension = "sqlite"
    
    public let cityDao: CityDAO
    public let commandDao: CommandDAO
    public let gameDao: GameDAO
    public let mapDao: MapDAO
    public let terrainDao: TerrainDAO
    public let unitDao: UnitDAO
    
    public init(fullRefresh: Bool) {
        let dbBundlePath = dbFilename
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let docsDbUrl = documentsDirectory.appendingPathComponent("\(dbFilename).\(dbExtension)")
        
        if let dbBundleUrl = Bundle.main.url(forResource: dbBundlePath, withExtension: dbExtension) {
            if fullRefresh {
                do {
                    if fileManager.fileExists(atPath: docsDbUrl.path) {
                        do {
                            try fileManager.removeItem(atPath: docsDbUrl.path)
                        } catch let error {
                            print("error occurred, here are the details: \(error)")
                        }
                    }
                    
                    try fileManager.copyItem(atPath: dbBundleUrl.path, toPath: docsDbUrl.path)
                } catch {
                    print("Unable to copy \(dbFilename).\(dbExtension): \(error)")
                }
            } else {
                // Copy the db file from the bundle if it's not in the Documents directory
                if !fileManager.fileExists(atPath: docsDbUrl.path) {
                    do {
                        try fileManager.copyItem(atPath: dbBundleUrl.path, toPath: docsDbUrl.path)
                    } catch let error {
                        print("error occurred, here are the details: \(error)")
                    }
                }
            }
        }
        else {
            print("Unable to find the \"Documents\" directory.")
            // throw SQLiteError.OpenDatabase(message: "Unable to find the \"Documents\" directory.")
        }
        
        let docDirUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        if docDirUrls.count == 0 {
            print("Unable to find the \"Documents\" directory.")
            // throw SQLiteError.OpenDatabase(message: "Unable to find the \"Documents\" directory.")
        }
        
        let documentsUrl = docDirUrls[0]
        let dbPath = documentsUrl.appendingPathComponent("\(dbFilename).\(dbExtension)").path
        
        var rc: Int32
        rc = sqlite3_open_v2(dbPath, &dbPointer, SQLITE_OPEN_READWRITE, nil)
        
        if (rc != SQLITE_OK) {
            let sqliteMsg = String(cString: sqlite3_errmsg(dbPointer))
            let errMsg = "Failed to open database connection to " + dbPath + ".  " + sqliteMsg
            print(errMsg)
            // throw SQLiteError.OpenDatabase(message: errMsg)
        }
        
        // Enable foreign keys (they are off by default in SQLite as of version 3.34)
        let pragma = "PRAGMA foreign_keys = ON;"
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(dbPointer, pragma, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                // logger.debug("Turned on foreign keys using command \"\(pragma, privacy: .public)\"")
            } else {
                let errMsg = String(cString: sqlite3_errmsg(dbPointer)!)
                print(errMsg)
                // throw SQLiteError.OpenDatabase(message: errMsg)
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(dbPointer)!)
            print(errMsg)
            // throw SQLiteError.OpenDatabase(message: errMsg)
        }
        
        sqlite3_finalize(stmt)
        
        cityDao = CityDAO(conn: dbPointer)
        commandDao = CommandDAO(conn: dbPointer)
        gameDao = GameDAO(conn: dbPointer)
        mapDao = MapDAO(conn: dbPointer)
        terrainDao = TerrainDAO(conn: dbPointer)
        unitDao = UnitDAO(conn: dbPointer)
    }
    
    public func getGameBy(gameId: Int) throws -> Game {
        let theme = Theme(id: 2, name: "Sci-Fi")
        let game = Game(theme: theme)
        let turn = Turn(id: 1, year: 1900, ordinal: 55, displayText: "1900")
        
        game.map = try mapDao.get(gameId: gameId)

        // Pull the map from the database
        let player1 = Player(playerId: 1)
        let cities = try cityDao.getCities(gameId: 1)
        let units = try unitDao.getUnits(gameId: 1)

        for city in cities {
            player1.add(city: city)
        }

        for unit in units {
            player1.add(unit: unit)
        }

        game.addPlayer(player: player1)
        
        let newYork = City(theme: theme,
                           player: player1,
                           name: "New York",
                           assetName: "city-1",
                           position: Position(row: 50, col: 50))
        let createNewYork = CreateCityCommand(commandId: 1,
                                              gameId: 1,
                                              turn: turn,
                                              player: player1,
                                              type: CommandType.init(id: 1, name: "Create City"),
                                              ordinal: 1,
                                              city: newYork,
                                              position: newYork.position)
        
        game.addCommand(command: createNewYork)
        
        return game
    }
    
    deinit {
        // let rc: Int32 = sqlite3_close_v2(dbPointer)
        
        // if (rc != SQLITE_OK) {
        //     let sqliteMsg = String(cString: sqlite3_errmsg(dbPointer))
        //     logger.error("\(sqliteMsg)")
        // }
    }
}

