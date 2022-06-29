//import XCTest
//import Engine
//
//class MapDAOTests: XCTestCase {
//    private var db = TestUtils.getDb()
//
//    override func setUpWithError() throws {
//        db = TestUtils.getDb()
//    }
//
//    func testInsertFourTilesExpectsSuccess() throws {
//        let map = Map(width: 2, height: 2)
//        let terrain = try TerrainFactory.create(terrainType: TerrainType.Grassland)
//
//        map.add(tile: Tile(position: Position(row: 0, col: 0), terrain: terrain))
//        map.add(tile: Tile(position: Position(row: 0, col: 1), terrain: terrain))
//        map.add(tile: Tile(position: Position(row: 1, col: 0), terrain: terrain))
//        map.add(tile: Tile(position: Position(row: 1, col: 1), terrain: terrain))
//
//        let newMap = try db.mapDao.insert(map: map)
//
//        XCTAssertEqual(newMap.mapId, 1)
//        XCTAssertEqual(newMap.width, 2)
//        XCTAssertEqual(newMap.height, 2)
//    }
//
//    func testGetMap1() throws {
//        let terrain00 = try TerrainFactory.create(terrainType: TerrainType.Grassland)
//        let terrain01 = try TerrainFactory.create(terrainType: TerrainType.Mountains)
//        let terrain10 = try TerrainFactory.create(terrainType: TerrainType.Forest)
//        let terrain11 = try TerrainFactory.create(terrainType: TerrainType.Desert)
//
//        let map1 = Map(mapId: -1, width: 2, height: 2)
//        map1.add(tile: Tile(position: Position(row: 0, col: 0), terrain: terrain00))
//        map1.add(tile: Tile(position: Position(row: 0, col: 1), terrain: terrain01))
//        map1.add(tile: Tile(position: Position(row: 1, col: 0), terrain: terrain10))
//        map1.add(tile: Tile(position: Position(row: 1, col: 1), terrain: terrain11))
//
//        // Make sure our initial map has all the correct terrain positions
//        XCTAssertEqual(map1.tile(at: Position(row: 0, col: 0)).id, -1)
//        XCTAssertEqual(map1.tile(at: Position(row: 0, col: 1)).id, -1)
//        XCTAssertEqual(map1.tile(at: Position(row: 1, col: 0)).id, -1)
//        XCTAssertEqual(map1.tile(at: Position(row: 1, col: 1)).id, -1)
//        XCTAssertEqual(map1.tile(at: Position(row: 0, col: 0)).terrain, terrain00)
//        XCTAssertEqual(map1.tile(at: Position(row: 0, col: 1)).terrain, terrain01)
//        XCTAssertEqual(map1.tile(at: Position(row: 1, col: 0)).terrain, terrain10)
//        XCTAssertEqual(map1.tile(at: Position(row: 1, col: 1)).terrain, terrain11)
//
//        // Save the map to the database
//        _ = try db.mapDao.insert(map: map1)
//
//        // Now get the map back out of the database
//        let map2 = try db.mapDao.get(gameId: 1)
//
//        XCTAssertEqual(map2.mapId, 1)
//        XCTAssertEqual(map2.width, 2)
//        XCTAssertEqual(map2.height, 2)
//
//        XCTAssertEqual(map2.tile(at: Position(row: 0, col: 0)).id, 1)
//        XCTAssertEqual(map2.tile(at: Position(row: 0, col: 1)).id, 2)
//        XCTAssertEqual(map2.tile(at: Position(row: 1, col: 0)).id, 3)
//        XCTAssertEqual(map2.tile(at: Position(row: 1, col: 1)).id, 4)
//
//        XCTAssertEqual(map2.tile(at: Position(row: 0, col: 0)).terrain, terrain00)
//        XCTAssertEqual(map2.tile(at: Position(row: 0, col: 1)).terrain, terrain01)
//        XCTAssertEqual(map2.tile(at: Position(row: 1, col: 0)).terrain, terrain10)
//        XCTAssertEqual(map2.tile(at: Position(row: 1, col: 1)).terrain, terrain11)
//
//    }
//
//    func testInsert() throws {
//        let terrain00 = try TerrainFactory.create(terrainType: TerrainType.Grassland)
//        let terrain01 = try TerrainFactory.create(terrainType: TerrainType.Mountains)
//        let terrain10 = try TerrainFactory.create(terrainType: TerrainType.Forest)
//        let terrain11 = try TerrainFactory.create(terrainType: TerrainType.Desert)
//
//        let map1 = Map(mapId: -1, width: 2, height: 2)
//        map1.add(tile: Tile(position: Position(row: 0, col: 0), terrain: terrain00))
//        map1.add(tile: Tile(position: Position(row: 0, col: 1), terrain: terrain01))
//        map1.add(tile: Tile(position: Position(row: 1, col: 0), terrain: terrain10))
//        map1.add(tile: Tile(position: Position(row: 1, col: 1), terrain: terrain11))
//
//        // All tile ids will be -1 before being saved to the database
//        XCTAssertEqual(map1.tile(at: Position(row: 0, col: 0)).id, -1)
//        XCTAssertEqual(map1.tile(at: Position(row: 0, col: 1)).id, -1)
//        XCTAssertEqual(map1.tile(at: Position(row: 1, col: 0)).id, -1)
//        XCTAssertEqual(map1.tile(at: Position(row: 1, col: 1)).id, -1)
//
//        // Save the map to the database
//        let map2 = try db.mapDao.insert(map: map1)
//
//        XCTAssertEqual(map2.mapId, 1)
//        XCTAssertEqual(map2.width, 2)
//        XCTAssertEqual(map2.height, 2)
//        XCTAssertEqual(map2.tile(at: Position(row: 0, col: 0)).id, 1)
//        XCTAssertEqual(map2.tile(at: Position(row: 0, col: 1)).id, 2)
//        XCTAssertEqual(map2.tile(at: Position(row: 1, col: 0)).id, 3)
//        XCTAssertEqual(map2.tile(at: Position(row: 1, col: 1)).id, 4)
//
//    }
//
//}
