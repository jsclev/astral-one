import XCTest
import Engine

class MapTests: XCTestCase {
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
        map.add(node: Node(row: 0, col: 0, terrain: TerrainFactory.create(terrainType: TerrainType.Desert)))
        map.add(node: Node(row: 0, col: 1, terrain: TerrainFactory.create(terrainType: TerrainType.Forest)))
        map.add(node: Node(row: 0, col: 2, terrain: TerrainFactory.create(terrainType: TerrainType.Glacier)))
        map.add(node: Node(row: 0, col: 3, terrain: TerrainFactory.create(terrainType: TerrainType.Grassland)))
        map.add(node: Node(row: 1, col: 0, terrain: TerrainFactory.create(terrainType: TerrainType.Hills)))
        map.add(node: Node(row: 1, col: 1, terrain: TerrainFactory.create(terrainType: TerrainType.Jungle)))
        map.add(node: Node(row: 1, col: 2, terrain: TerrainFactory.create(terrainType: TerrainType.Mountains)))
        map.add(node: Node(row: 1, col: 3, terrain: TerrainFactory.create(terrainType: TerrainType.Ocean)))
        map.add(node: Node(row: 2, col: 0, terrain: TerrainFactory.create(terrainType: TerrainType.Plains)))
        map.add(node: Node(row: 2, col: 1, terrain: TerrainFactory.create(terrainType: TerrainType.Swamp)))
        map.add(node: Node(row: 2, col: 2, terrain: TerrainFactory.create(terrainType: TerrainType.Tundra)))
        map.add(node: Node(row: 2, col: 3, terrain: TerrainFactory.create(terrainType: TerrainType.Water)))
        
        // Make sure we have the correctly sized movement cost map
        XCTAssertEqual(map.getMovementCosts().count, 4)
        for i in 0..<4 {
            XCTAssertEqual(map.getMovementCosts()[i].count, 4)
        }
        
        // Make sure we got a movement cost for mountain
        XCTAssertEqual(map.getMovementCosts()[0][0], 1.0)
        XCTAssertEqual(map.getMovementCosts()[0][1], 2.0)
        XCTAssertEqual(map.getMovementCosts()[0][2], 2.0)
        XCTAssertEqual(map.getMovementCosts()[0][3], 1.0)
        XCTAssertEqual(map.getMovementCosts()[1][0], 2.0)
        XCTAssertEqual(map.getMovementCosts()[1][1], 2.0)
        XCTAssertEqual(map.getMovementCosts()[1][2], 3.0)
        XCTAssertEqual(map.getMovementCosts()[1][3], 1.0)
        XCTAssertEqual(map.getMovementCosts()[2][0], 1.0)
        XCTAssertEqual(map.getMovementCosts()[2][1], 2.0)
        XCTAssertEqual(map.getMovementCosts()[2][2], 1.0)
    }
    
    func testGetMoveCostTwoGrassNodes() throws {
        let map = Map(width: 2, height: 1)
        map.add(node: Node(row: 0, col: 0, terrain: TerrainFactory.create(terrainType: TerrainType.Grassland)))
        map.add(node: Node(row: 0, col: 1, terrain: TerrainFactory.create(terrainType: TerrainType.Grassland)))
        
        XCTAssertEqual(map.getMovementCosts().count, 1)
        XCTAssertEqual(map.getMovementCosts()[0].count, 2)
    }
    
    func testGetMoveCostsExpectsModifiers() throws {
        let map = Map(width: 2, height: 2)
        let node00 = Node(row: 0,
                          col: 0,
                          terrain: TerrainFactory.create(terrainType: TerrainType.Grassland))
        node00.add(movementModifier: MovementModifier(name: "", movementCost: 100.0))
        
        let node01 = Node(row: 0,
                          col: 1,
                          terrain: TerrainFactory.create(terrainType: TerrainType.Grassland))
        node01.add(movementModifier: MovementModifier(name: "", movementCost: 200.0))
        
        let node10 = Node(row: 1,
                          col: 0,
                          terrain: TerrainFactory.create(terrainType: TerrainType.Grassland))
        node10.add(movementModifier: MovementModifier(name: "", movementCost: 300.0))
        
        let node11 = Node(row: 1,
                          col: 1,
                          terrain: TerrainFactory.create(terrainType: TerrainType.Grassland))
        node11.add(movementModifier: MovementModifier(name: "", movementCost: 400.0))
        
        map.add(node: node00)
        map.add(node: node01)
        map.add(node: node10)
        map.add(node: node11)

        let movementCosts = map.getMovementCosts()
        XCTAssertEqual(movementCosts[0][0], 100.0)
        XCTAssertEqual(movementCosts[0][1], 200.0)
        XCTAssertEqual(movementCosts[1][0], 300.0)
        XCTAssertEqual(movementCosts[1][1], 400.0)
    }

}
