import XCTest
import Engine

class TerrainDAOTests: XCTestCase {
    private var db = TestUtil.getDb()
    
    override func setUpWithError() throws {
        db = TestUtil.getDb()
    }

    func testGetAll() throws {
        let terrains = try db.terrainDao.getTerrains()
        
        XCTAssertEqual(terrains.count, 31)
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Desert",
                                                type: TerrainType.Desert,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Forest",
                                                type: TerrainType.Forest,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Glacier",
                                                type: TerrainType.Glacier,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Grass",
                                                type: TerrainType.Grassland,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Hills",
                                                type: TerrainType.Hills,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Jungle",
                                                type: TerrainType.Jungle,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Mountain",
                                                type: TerrainType.Mountains,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Water",
                                                type: TerrainType.Ocean,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Plains",
                                                type: TerrainType.Plains,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "River",
                                                type: TerrainType.River,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Swamp",
                                                type: TerrainType.Swamp,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
        XCTAssertTrue(terrains.contains(Terrain(id: -1,
                                                tiledId: 0,
                                                name: "Tundra",
                                                type: TerrainType.Tundra,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0)))
    }

}
