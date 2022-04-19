import XCTest
import Engine

class TerrainDAOTests: XCTestCase {
    private var db = TestUtil.getDb()
    
    override func setUpWithError() throws {
        db = TestUtil.getDb()
    }

    func testGetAll() throws {
        let terrains = try db.terrainDao.getTerrains()
        
        XCTAssertEqual(terrains.count, 12)
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Desert,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Forest,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Glacier,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Grassland,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Hills,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Jungle,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Mountains,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Ocean,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Plains,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.River,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Swamp,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                type: TerrainType.Tundra,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
    }

}
