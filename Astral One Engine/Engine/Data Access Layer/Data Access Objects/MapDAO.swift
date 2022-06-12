import Foundation
import SQLite3

public class MapDAO: BaseDAO {
    init(conn: OpaquePointer?) {
        super.init(conn: conn, table: "tile", loggerName: String(describing: type(of: self)))
    }
    
    public func get(gameId: Int) throws -> Map {
        var tiles: [Tile] = []
        var maxRow = 0
        var maxCol = 0
        
        var stmt: OpaquePointer?
        let sql = """
            SELECT
                t.tile_id,
                t.game_id,
                t.map_id,
                t.row,
                t.col,
                t.terrain_id,
                t.has_river,
                t.special_resource,
                te.tiled_id,
                te.terrain_type,
                te.food,
                te.shields,
                te.trade,
                te.movement_cost,
                te.defensive_bonus
            FROM
                tile t
            INNER JOIN
                terrain te ON te.terrain_id = t.terrain_id
            WHERE
                t.game_id = 1
        """
        
        if sqlite3_prepare_v2(conn, sql, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let tileId = getInt(stmt: stmt, colIndex: 0)
                // let gameId = getInt(stmt: stmt, colIndex: 1)
                // let mapId = getInt(stmt: stmt, colIndex: 2)
                let row = getInt(stmt: stmt, colIndex: 3)
                let col = getInt(stmt: stmt, colIndex: 4)
                let terrainId = getInt(stmt: stmt, colIndex: 5)
                let tiledId = getInt(stmt: stmt, colIndex: 8)
                
                if let terrainTypeText = try getString(stmt: stmt, colIndex: 9) {
                    let terrainType = getTerrainType(terrainTypeText: terrainTypeText)
                    
                    maxRow = row > maxRow ? row : maxRow
                    maxCol = col > maxCol ? col : maxCol
                    
                    if let specialResourceText = try getString(stmt: stmt, colIndex: 7) {
                        let srType = getSpecialResource(specialResourceText: specialResourceText)
                        
                        tiles.append(Tile(id: tileId,
                                          position: Position(row: row, col: col),
                                          terrain: Terrain(id: terrainId,
                                                           tiledId: tiledId,
                                                           name: terrainTypeText,
                                                           type: terrainType),
                                          specialResource: srType))
                    }
                    else {
                        tiles.append(Tile(id: tileId,
                                          position: Position(row: row, col: col),
                                          terrain: Terrain(id: terrainId,
                                                           tiledId: tiledId,
                                                           name: terrainTypeText,
                                                           type: terrainType)))
                    }
                }
                else {
                    fatalError("Terrain cannot be NULL.")
                }
            }
        }
        
        sqlite3_finalize(stmt)
        
        let returnMap = Map(mapId: 1, width: maxCol + 1, height: maxRow + 1)
        
        for tile in tiles {
            returnMap.add(tile: tile)
        }
        
        return returnMap
    }
    
    private func getTerrainType(terrainTypeText: String) -> TerrainType {
        switch terrainTypeText {
        case "Desert":
            return TerrainType.Desert
        case "Forest":
            return TerrainType.Forest
        case "Glacier":
            return TerrainType.Glacier
        case "Grass":
            return TerrainType.Grassland
        case "Hills":
            return TerrainType.Hills
        case "Jungle":
            return TerrainType.Jungle
        case "Mountain":
            return TerrainType.Mountains
        case "Water":
            return TerrainType.Ocean
        case "Plains":
            return TerrainType.Plains
        case "River":
            return TerrainType.River
        case "Swamp":
            return TerrainType.Swamp
        case "Tundra":
            return TerrainType.Tundra
        default:
            fatalError("Should not have gotten here.")
        }
    }
    
    private func getSpecialResource(specialResourceText: String) -> SpecialResourceType {
        switch specialResourceText {
        case "Buffalo":
            return SpecialResourceType.Buffalo
        case "Coal":
            return SpecialResourceType.Coal
        case "Fish":
            return SpecialResourceType.Fish
        case "Fruit":
            return SpecialResourceType.Fruit
        case "Furs":
            return SpecialResourceType.Furs
        case "Game":
            return SpecialResourceType.Game
        case "Gems":
            return SpecialResourceType.Gems
        case "Gold":
            return SpecialResourceType.Gold
        case "Iron":
            return SpecialResourceType.Iron
        case "Ivory":
            return SpecialResourceType.Ivory
        case "Oasis":
            return SpecialResourceType.Oasis
        case "Oil":
            return SpecialResourceType.Oil
        case "Peat":
            return SpecialResourceType.Peat
        case "Pheasant":
            return SpecialResourceType.Pheasant
        case "Silk":
            return SpecialResourceType.Silk
        case "Spice":
            return SpecialResourceType.Spice
        case "Whales":
            return SpecialResourceType.Whales
        case "Wheat":
            return SpecialResourceType.Wheat
        case "Wine":
            return SpecialResourceType.Wine
        default:
            fatalError("Should not have gotten here.")
        }
    }
    
    private func getRandomResource(terrainType: TerrainType) -> SpecialResourceType? {
        return nil
        let randomNum = Int.random(in: 0..<2)
        switch terrainType {
        case .Desert:
            if randomNum == 0 {
                return SpecialResourceType.Oasis
            }
            else {
                return SpecialResourceType.Oil
            }
        case .Forest:
            if randomNum == 0 {
                return SpecialResourceType.Pheasant
            }
            else {
                return SpecialResourceType.Silk
            }
        case .Glacier:
            if randomNum == 0 {
                return SpecialResourceType.Ivory
            }
            else {
                return SpecialResourceType.Oil
            }
        case .Grassland:
            return nil
        case .Hills:
            if randomNum == 0 {
                return SpecialResourceType.Coal
            }
            else {
                return SpecialResourceType.Wine
            }
        case .Jungle:
            if randomNum == 0 {
                return SpecialResourceType.Gems
            }
            else {
                return SpecialResourceType.Fruit
            }
        case .Mountains:
            if randomNum == 0 {
                return SpecialResourceType.Gold
            }
            else {
                return SpecialResourceType.Iron
            }
        case .Ocean:
            if randomNum == 0 {
                return SpecialResourceType.Fish
            }
            else {
                return SpecialResourceType.Whales
            }
        case .Plains:
            if randomNum == 0 {
                return SpecialResourceType.Buffalo
            }
            else {
                return SpecialResourceType.Wheat
            }
        case .River:
            return nil
        case .Swamp:
            if randomNum == 0 {
                return SpecialResourceType.Peat
            }
            else {
                return SpecialResourceType.Spice
            }
        case .Tundra:
            return SpecialResourceType.Furs
        case .Unknown:
            return nil
        }
    }
        
    public func insert(map: Map) throws -> Map {
        var mainStmt: OpaquePointer?
        var rowIdStmt: OpaquePointer?
        
        let mainSql =
            """
            INSERT INTO \(table)
            (game_id, map_id, row, col, terrain_id, has_river, special_resource)
            VALUES (?, ?, ?, ?, ?, ?, ?);
            """
        
        let rowIdSql = "SELECT last_insert_rowid()"
        
        if sqlite3_exec(conn, "BEGIN TRANSACTION", nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(rowIdStmt)
            
            throw SQLiteError.Prepare(message: errMsg)
        }
        
        if sqlite3_prepare_v2(conn, rowIdSql, -1, &rowIdStmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(rowIdStmt)
            
            throw SQLiteError.Prepare(message: errMsg)
        }
        
        if sqlite3_prepare_v2(conn, mainSql, -1, &mainStmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(conn)!)
            sqlite3_finalize(rowIdStmt)
            
            throw SQLiteError.Prepare(message: errMsg)
        }
        
        for row in 0..<map.height {
            for col in 0..<map.width {
                let tile = map.tile(at: Position(row: row, col: col))
                
                sqlite3_bind_int(mainStmt, 1, Int32(1))
                sqlite3_bind_int(mainStmt, 2, Int32(1))
                sqlite3_bind_int(mainStmt, 3, Int32(row))
                sqlite3_bind_int(mainStmt, 4, Int32(col))
                sqlite3_bind_int(mainStmt, 5, Int32(tile.terrain.id))
                sqlite3_bind_int(mainStmt, 6, Int32(0))
                
                if let sr = tile.specialResource {
                    sqlite3_bind_text(mainStmt, 7, sr.description, -1, SQLITE_TRANSIENT)
                }
                else {
                    sqlite3_bind_text(mainStmt, 7, nil, -1, SQLITE_TRANSIENT)
                }
                
                if sqlite3_step(mainStmt) == SQLITE_DONE {
                    if sqlite3_step(rowIdStmt) == SQLITE_ROW {
                        //returnMap.add(tile: tile.clone())
                    }
                    else {
                        let errMsg = String(cString: sqlite3_errmsg(conn)!)
                        sqlite3_finalize(rowIdStmt)
                        
                        throw SQLiteError.Step(message: errMsg)
                    }
                }
                else {
                    print("\nCould not insert row into \(table) table.")
                }
                
                sqlite3_reset(mainStmt)
                sqlite3_reset(rowIdStmt)
            }
        }
        
        sqlite3_finalize(mainStmt)
        
        if sqlite3_exec (conn, "COMMIT TRANSACTION", nil, nil, nil) != SQLITE_OK {
            print("Error!!!!")
        }
        
        return try get(gameId: 1)
    }
    
    public func importTiledMap(filename: String) throws {
        let tilesetParser = TiledTilesetParser()
        let tileset = tilesetParser.parse()
        let mapParser = TiledMapParser(tiledTileset: tileset, filename: filename)
        
        // Import the Tiled map into the database
        let _ = try insert(map: mapParser.parse())
    }
}
