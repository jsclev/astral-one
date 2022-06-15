import XCTest
import Engine

class MapTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }
    
    func testGetMoveCostsExpectsMin() throws {
        let map = Map(width: 10, height: 5)
        let movementCosts = map.getMovementCosts()
        
        XCTAssertEqual(movementCosts.count, 5)
        
        for row in 0..<5 {
            XCTAssertEqual(movementCosts[row].count, 10)
            
            for col in 0..<10 {
                XCTAssertEqual(map.getMovementCosts()[row][col], Constants.minMovementCost)
            }
        }
    }
    
    func testGetMoveCostsBaseTerrain() throws {
        let map = Map(width: 4, height: 4)
        try map.add(tile: Tile(position: Position(row: 0, col: 0),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Desert)))
        try map.add(tile: Tile(position: Position(row: 0, col: 1),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Forest)))
        try map.add(tile: Tile(position: Position(row: 0, col: 2),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Glacier)))
        try map.add(tile: Tile(position: Position(row: 0, col: 3),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Grassland)))
        try map.add(tile: Tile(position: Position(row: 1, col: 0),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Hills)))
        try map.add(tile: Tile(position: Position(row: 1, col: 1),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Jungle)))
        try map.add(tile: Tile(position: Position(row: 1, col: 2),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Mountains)))
        try map.add(tile: Tile(position: Position(row: 1, col: 3),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Ocean)))
        try map.add(tile: Tile(position: Position(row: 2, col: 0),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Plains)))
        try map.add(tile: Tile(position: Position(row: 2, col: 1),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Swamp)))
        try map.add(tile: Tile(position: Position(row: 2, col: 2),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Tundra)))
        try map.add(tile: Tile(position: Position(row: 2, col: 3),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Ocean)))
        
        // Make sure we have the correctly sized movement cost map
        XCTAssertEqual(map.getMovementCosts().count, 4)
        for i in 0..<4 {
            XCTAssertEqual(map.getMovementCosts()[i].count, 4)
        }
        
        // Make sure we got a movement cost for mountain
        XCTAssertEqual(map.getMovementCosts()[0][0], 1.0, accuracy: 0.001)
        XCTAssertEqual(map.getMovementCosts()[0][1], 2.0, accuracy: 0.000001)
        XCTAssertEqual(map.getMovementCosts()[0][2], 2.0, accuracy: 0.000001)
        XCTAssertEqual(map.getMovementCosts()[0][3], 1.0, accuracy: 0.000001)
        XCTAssertEqual(map.getMovementCosts()[1][0], 2.0, accuracy: 0.000001)
        XCTAssertEqual(map.getMovementCosts()[1][1], 2.0, accuracy: 0.000001)
        XCTAssertEqual(map.getMovementCosts()[1][2], 3.0, accuracy: 0.000001)
        XCTAssertEqual(map.getMovementCosts()[1][3], 1.0, accuracy: 0.000001)
        XCTAssertEqual(map.getMovementCosts()[2][0], 1.0, accuracy: 0.000001)
        XCTAssertEqual(map.getMovementCosts()[2][1], 2.0, accuracy: 0.000001)
        XCTAssertEqual(map.getMovementCosts()[2][2], 1.0, accuracy: 0.000001)
    }
    
    func testGetMoveCostTwoGrassNodes() throws {
        let map = Map(width: 2, height: 1)
        try map.add(tile: Tile(position: Position(row: 0, col: 0),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Grassland)))
        try map.add(tile: Tile(position: Position(row: 0, col: 1),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Grassland)))
        
        XCTAssertEqual(map.getMovementCosts().count, 1)
        XCTAssertEqual(map.getMovementCosts()[0].count, 2)
    }
    
    func testGetMoveCostsExpectsModifiers() throws {
        let map = Map(width: 2, height: 2)
        let tile00 = Tile(position: Position(row: 0, col: 0),
                          terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland))
        tile00.add(movementModifier: MovementModifier(name: "", movementCost: 100.0))
        
        let tile01 = Tile(position: Position(row: 0, col: 1),
                          terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland))
        tile01.add(movementModifier: MovementModifier(name: "", movementCost: 200.0))
        
        let tile10 = Tile(position: Position(row: 1, col: 0),
                          terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland))
        tile10.add(movementModifier: MovementModifier(name: "", movementCost: 300.0))
        
        let tile11 = Tile(position: Position(row: 1, col: 1),
                          terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland))
        tile11.add(movementModifier: MovementModifier(name: "", movementCost: 400.0))
        
        map.add(tile: tile00)
        map.add(tile: tile01)
        map.add(tile: tile10)
        map.add(tile: tile11)
        
        let movementCosts = map.getMovementCosts()
        XCTAssertEqual(movementCosts[0][0], 100.0)
        XCTAssertEqual(movementCosts[0][1], 200.0)
        XCTAssertEqual(movementCosts[1][0], 300.0)
        XCTAssertEqual(movementCosts[1][1], 400.0)
    }
    
    func testAddTileExpectsInvalidRow() throws {
        let map = Map(mapId: 1, width: 1, height: 1)
        let tile = Tile(position: Position(row: -1, col: 0),
                        terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland))
        
        XCTAssertThrowsError(map.add(tile: tile)) { error in
            let errorMsg = "Row must be greater than or equal to zero."
            XCTAssertEqual(error as? MapError, MapError.invalidRow(message: errorMsg, row: -1))
        }
    }
    
}
