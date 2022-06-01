import XCTest
import Engine

class TerrainTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }
    
    func testEqualsExpectsTrue() throws {
        // Set up two terrain objects with the same ids
        let terrain1 = Terrain(id: 1,
                               tiledId: 0,
                               name: "test1",
                               type: TerrainType.Grassland)
        let terrain2 = Terrain(id: 1,
                               tiledId: 1,
                               name: "test2",
                               type: TerrainType.Desert)
        
        XCTAssertEqual(terrain1, terrain2)
    }
    
    func testEqualsExpectsFalse() throws {
        // Set up two terrain objects with different ids
        let terrain1 = Terrain(id: 1,
                               tiledId: 1,
                               name: "test1",
                               type: TerrainType.Grassland)
        let terrain2 = Terrain(id: 2,
                               tiledId: 1,
                               name: "test1",
                               type: TerrainType.Grassland)
        
        XCTAssertNotEqual(terrain1, terrain2)
    }

}
