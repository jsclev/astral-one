import Foundation
import os
import SQLite3

public class Db {
    //    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Db")
    var dbPointer: OpaquePointer?
    let dbFilename = "civitas"
    let dbExtension = "sqlite"
    
    public let gameDao: GameDAO
    public let commandDao: CommandDAO
    
    init(fullRefresh: Bool) {
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
            //            throw SQLiteError.OpenDatabase(message: "Unable to find the \"Documents\" directory.")
        }
        
        let docDirUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        if docDirUrls.count == 0 {
            print("Unable to find the \"Documents\" directory.")
            //            throw SQLiteError.OpenDatabase(message: "Unable to find the \"Documents\" directory.")
        }
        
        let documentsUrl = docDirUrls[0]
        let dbPath = documentsUrl.appendingPathComponent("\(dbFilename).\(dbExtension)").path
        
        var rc: Int32
        rc = sqlite3_open_v2(dbPath, &dbPointer, SQLITE_OPEN_READWRITE, nil)
        
        if (rc != SQLITE_OK) {
            let sqliteMsg = String(cString: sqlite3_errmsg(dbPointer))
            let errMsg = "Failed to open database connection to " + dbPath + ".  " + sqliteMsg
            print(errMsg)
            //            throw SQLiteError.OpenDatabase(message: errMsg)
        }
        
        //        logger.debug("Opened database at \(dbPath, privacy: .public).")
        
        // Enable foreign keys (they are off by default in SQLite as of version 3.34)
        let pragma = "PRAGMA foreign_keys = ON;"
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(dbPointer, pragma, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                //                logger.debug("Turned on foreign keys using command \"\(pragma, privacy: .public)\"")
            } else {
                let errMsg = String(cString: sqlite3_errmsg(dbPointer)!)
                print(errMsg)
                //                throw SQLiteError.OpenDatabase(message: errMsg)
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(dbPointer)!)
            print(errMsg)
            //            throw SQLiteError.OpenDatabase(message: errMsg)
        }
        
        sqlite3_finalize(stmt)
        
        gameDao = GameDAO(conn: dbPointer)
        commandDao = CommandDAO(conn: dbPointer)
    }
    
    deinit {
        //        let rc: Int32 = sqlite3_close_v2(dbPointer)
        
        //        if (rc != SQLITE_OK) {
        //            let sqliteMsg = String(cString: sqlite3_errmsg(dbPointer))
        //            logger.error("\(sqliteMsg)")
        //        }
    }
}

