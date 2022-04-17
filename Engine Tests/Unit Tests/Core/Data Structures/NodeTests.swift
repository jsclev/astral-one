import XCTest
import Engine


class NodeTests: XCTestCase {
    func testMovementCostZeroTerrain() {
        // Because A* has problems with 0 (zero) cost nodes, we
        // want to make sure the minimum movement cost of any node
        // will always be more than zero.
        
        // Purposefully attempt to create a node with zero movement cost terrain
        let tile = Tile(row: 0, col: 0, terrain: Terrain(name: "Grass",
                                                         food: 0.0,
                                                         shields: 0.0,
                                                         trade: 0.0,
                                                         movementCost: 0.0))
        // Make sure the node's movement cost is greater than zero
        XCTAssertEqual(tile.getMovementCost(), Constants.minMovementCost)
    }
    
    func testMovementCostNegTerrain() {
        let tile = Tile(row: 0, col: 0, terrain: Terrain(name: "Grass",
                                                         food: 0.0,
                                                         shields: 0.0,
                                                         trade: 0.0,
                                                         movementCost: -1.0))
        
        // Make sure the node's movement cost is greater than zero, even
        // though we purposefully gave the terrain negative movement cost
        XCTAssertEqual(tile.getMovementCost(), Constants.minMovementCost)
    }
    
    func testMovementCostNormalTerrain() {
        let tile = Tile(row: 0, col: 0, terrain: Terrain(name: "Test",
                                                         food: 0.0,
                                                         shields: 0.0,
                                                         trade: 0.0,
                                                         movementCost: 1.0))
        XCTAssertEqual(tile.getMovementCost(), 1.0)
    }
    
    func testMovementCostModifier1() {
        let tile = Tile(row: 0, col: 0, terrain: Terrain(name: "Test",
                                                         food: 0.0,
                                                         shields: 0.0,
                                                         trade: 0.0,
                                                         movementCost: -1.0))
        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0 / 3.0))
        
        XCTAssertEqual(tile.getMovementCost(), 1.0 / 3.0)
    }
    
    func testMovementCostModifier2() {
        let tile = Tile(row: 0, col: 0, terrain: Terrain(name: "Test",
                                                         food: 0.0,
                                                         shields: 0.0,
                                                         trade: 0.0,
                                                         movementCost: 0.0))
        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0 / 3.0))

        XCTAssertEqual(tile.getMovementCost(), 1.0 / 3.0)
    }
    
    func testMovementCostModifier3() {
        let tile = Tile(row: 0, col: 0, terrain: Terrain(name: "Test",
                                                         food: 0.0,
                                                         shields: 0.0,
                                                         trade: 0.0,
                                                         movementCost: 1.0))
        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0 / 3.0))

        XCTAssertEqual(tile.getMovementCost(), 1.0 / 3.0)
    }
    
    func testMovementCostModifier4() {
        let tile = Tile(row: 0, col: 0, terrain: Terrain(name: "Test",
                                                         food: 0.0,
                                                         shields: 0.0,
                                                         trade: 0.0,
                                                         movementCost: 100.0))
        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0 / 3.0))

        XCTAssertEqual(tile.getMovementCost(), 1.0 / 3.0)
    }
    
    func testMovementCostModifier5() {
        let tile = Tile(row: 0, col: 0, terrain: Terrain(name: "Test",
                                                         food: 0.0,
                                                         shields: 0.0,
                                                         trade: 0.0,
                                                         movementCost: 1000.0))
        
        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0))
        XCTAssertEqual(tile.getMovementCost(), 1.0)
        
        tile.add(movementModifier: MovementModifier(name: "", movementCost: 3.0))
        XCTAssertEqual(tile.getMovementCost(), 3.0)
    }
    
//    func testPerformanceExample() throws {
//        let gridGraph = GridGraph(width: 5, height: 5)
//        var nodes: [Node] = []
//
//        for row in 0..<50 {
//            for col in 0..<50 {
//                nodes.append(Node(row: row, col: col))
//            }
//        }
//
//        self.measure {
//            for node in nodes {
//                gridGraph.add(node: node)
//            }
//
//            for node in nodes {
//                gridGraph.removeNode(nodeToDelete: node)
//            }
//        }
//    }

}
