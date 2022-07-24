import Foundation
import os
import SQLite3

public class Db {
    //    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Db")
    var db: OpaquePointer?
    let dbFilename = "game"
    let dbExtension = "sqlite"
    
    public let buildingTypeDao: BuildingTypeDAO
    public let buildBuildingCommandDao: BuildBuildingCommandDAO
    public let cityDao: CityDAO
    public let cityNameDao: CityNameDAO
    public let commandDao: CommandDAO
    public let createCityCommandDao: CreateCityCommandDAO
    public let createUnitCommandDao: CreateUnitCommandDAO
    public let gameDao: GameDAO
    public let mapDao: MapDAO
    public let moveUnitCommandDao: MoveUnitCommandDAO
    public let turnCommandDao: EndPlayerTurnCommandDAO
    public let playerDao: PlayerDAO
    public let researchAdvanceCommandDao: ResearchAdvanceCommandDAO
    public let skinDao: SkinDAO
    public let terrainDao: TerrainDAO
    public let themeDao: ThemeDAO
    public let turnDao: TurnDAO
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
        rc = sqlite3_open_v2(dbPath, &db, SQLITE_OPEN_READWRITE, nil)
        
        if (rc != SQLITE_OK) {
            let sqliteMsg = String(cString: sqlite3_errmsg(db))
            let errMsg = "Failed to open database connection to " + dbPath + ".  " + sqliteMsg
            print(errMsg)
            // throw SQLiteError.OpenDatabase(message: errMsg)
        }
        
        // Enable foreign keys (they are off by default in SQLite as of version 3.34)
        let pragma = "PRAGMA foreign_keys = ON;"
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(db, pragma, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                // logger.debug("Turned on foreign keys using command \"\(pragma, privacy: .public)\"")
            } else {
                let errMsg = String(cString: sqlite3_errmsg(db)!)
                print(errMsg)
                // throw SQLiteError.OpenDatabase(message: errMsg)
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print(errMsg)
            // throw SQLiteError.OpenDatabase(message: errMsg)
        }
        
        sqlite3_finalize(stmt)
        
        buildingTypeDao = BuildingTypeDAO(conn: db)
        cityNameDao = CityNameDAO(conn: db)
        cityDao = CityDAO(conn: db)
        unitDao = UnitDAO(conn: db)
        commandDao = CommandDAO(conn: db, cityDao: cityDao)
        createCityCommandDao = CreateCityCommandDAO(conn: db, commandDao: commandDao, cityDao: cityDao)
        createUnitCommandDao = CreateUnitCommandDAO(conn: db, commandDao: commandDao, unitDao: unitDao)
        turnCommandDao = EndPlayerTurnCommandDAO(conn: db, commandDao: commandDao)
        gameDao = GameDAO(conn: db)
        mapDao = MapDAO(conn: db)
        buildBuildingCommandDao = BuildBuildingCommandDAO(conn: db, commandDao: commandDao, buildingTypeDao: buildingTypeDao)
        moveUnitCommandDao = MoveUnitCommandDAO(conn: db, commandDao: commandDao)
        researchAdvanceCommandDao = ResearchAdvanceCommandDAO(conn: db, commandDao: commandDao)
        playerDao = PlayerDAO(conn: db, mapDao: mapDao, unitDao: unitDao, cityNameDao: cityNameDao)
        skinDao = SkinDAO(conn: db)
        terrainDao = TerrainDAO(conn: db)
        themeDao = ThemeDAO(conn: db)
        turnDao = TurnDAO(conn: db)
    }
    
    public func getGameBy(gameId: Int, themeId: Int) throws -> Game {
        let theme = try themeDao.getBy(themeId: themeId)
        let players = try playerDao.getPlayers(gameId: gameId)
        
        let map = try mapDao.get(gameId: gameId)
        map.revealAllTiles()
        
        return try Game(gameId: gameId, theme: theme, players: players, map: map, db: self)
    }
    
    deinit {
         let rc: Int32 = sqlite3_close_v2(db)
        
         if (rc != SQLITE_OK) {
             let sqliteMsg = String(cString: sqlite3_errmsg(db))
             print(sqliteMsg)
         }
    }
}

