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
                               terrain: TerrainFactory.create(terrainType: TerrainType.Desert),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 0, col: 1),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Forest),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 0, col: 2),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Glacier),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 0, col: 3),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Grassland),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 1, col: 0),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Hills),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 1, col: 1),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Jungle),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 1, col: 2),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Mountains),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 1, col: 3),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Ocean),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 2, col: 0),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Plains),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 2, col: 1),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Swamp),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 2, col: 2),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Tundra),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 2, col: 3),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Ocean),
                               hasRiver: false))
        
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
    
    func testGetDistanceToClosestCity() throws {
        let map = Map(width: 4, height: 4)
        let game = try Game(gameId: 1,
                            theme: Theme(id: Constants.noId, name: "test theme"),
                            map: map,
                            db: TestUtils.getDb())
        let player = AIPlayer(playerId: 1,
                              game: game,
                              map: map,
                              skillLevel: SkillLevel.One,
                              difficultyLevel: DifficultyLevel.Easy,
                              playStyle: AIStrategy(offense: 0.5, defense: 0.5))
        let turn = Turn(id: Constants.noId, year: 0, ordinal: 0, displayText: "test turn")
        
        map.add(tile: TestUtils.makeTile(0, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 0, TerrainType.Grassland))

        map.add(tile: TestUtils.makeTile(0, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 1, TerrainType.Grassland))

        map.add(tile: TestUtils.makeTile(0, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 2, TerrainType.Grassland))

        map.add(tile: TestUtils.makeTile(0, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 3, TerrainType.Grassland))

        // Put a city creator at the lower-left corner (0, 0)
        let cmd1 = CreateSettlerCommand(player: player,
                                        turn: turn,
                                        ordinal: 0,
                                        cost: 0,
                                        tile: map.tile(at: Position(row: 0, col: 0)))
        let _ = cmd1.execute()
        
        let cmd2 = CreateCityCommand(player: player,
                                     turn: turn,
                                     ordinal: 1,
                                     cost: 0,
                                     cityCreator: player.cityCreators[0],
                                     cityName: "test city")
        let _ = cmd2.execute()
        
        // Check distances from every tile to the city
        XCTAssertEqual(0, map.getDistanceToNearestCity(from: Position(row: 0, col: 0)))
        XCTAssertEqual(1, map.getDistanceToNearestCity(from: Position(row: 0, col: 1)))
        XCTAssertEqual(2, map.getDistanceToNearestCity(from: Position(row: 0, col: 2)))
        XCTAssertEqual(3, map.getDistanceToNearestCity(from: Position(row: 0, col: 3)))
        XCTAssertEqual(1, map.getDistanceToNearestCity(from: Position(row: 1, col: 0)))
        XCTAssertEqual(1, map.getDistanceToNearestCity(from: Position(row: 1, col: 1)))
        XCTAssertEqual(2, map.getDistanceToNearestCity(from: Position(row: 1, col: 2)))
        XCTAssertEqual(3, map.getDistanceToNearestCity(from: Position(row: 1, col: 3)))
        XCTAssertEqual(2, map.getDistanceToNearestCity(from: Position(row: 2, col: 0)))
        XCTAssertEqual(2, map.getDistanceToNearestCity(from: Position(row: 2, col: 1)))
        XCTAssertEqual(2, map.getDistanceToNearestCity(from: Position(row: 2, col: 2)))
        XCTAssertEqual(3, map.getDistanceToNearestCity(from: Position(row: 2, col: 3)))
        XCTAssertEqual(3, map.getDistanceToNearestCity(from: Position(row: 3, col: 0)))
        XCTAssertEqual(3, map.getDistanceToNearestCity(from: Position(row: 3, col: 1)))
        XCTAssertEqual(3, map.getDistanceToNearestCity(from: Position(row: 3, col: 2)))
        XCTAssertEqual(3, map.getDistanceToNearestCity(from: Position(row: 3, col: 3)))
    }
    
    func testGetMoveCostTwoGrassNodes() throws {
        let map = Map(width: 2, height: 1)
        try map.add(tile: Tile(position: Position(row: 0, col: 0),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Grassland),
                               hasRiver: false))
        try map.add(tile: Tile(position: Position(row: 0, col: 1),
                               terrain: TerrainFactory.create(terrainType: TerrainType.Grassland),
                               hasRiver: false))
        
        XCTAssertEqual(map.getMovementCosts().count, 1)
        XCTAssertEqual(map.getMovementCosts()[0].count, 2)
    }
    
    func testGetMoveCostsExpectsModifiers() throws {
        let map = Map(width: 2, height: 2)
        let tile00 = Tile(position: Position(row: 0, col: 0),
                          terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland),
                          hasRiver: false)
        let tile01 = Tile(position: Position(row: 0, col: 1),
                          terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland),
                          hasRiver: false)
        let tile10 = Tile(position: Position(row: 1, col: 0),
                          terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland),
                          hasRiver: false)
        let tile11 = Tile(position: Position(row: 1, col: 1),
                          terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland),
                          hasRiver: false)
        
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
                        terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland),
                        hasRiver: false)
        
        XCTAssertThrowsError(map.add(tile: tile)) { error in
            let errorMsg = "Row must be greater than or equal to zero."
            XCTAssertEqual(error as? MapError, MapError.invalidRow(message: errorMsg, row: -1))
        }
    }
    
}
