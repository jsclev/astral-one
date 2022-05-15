import XCTest
import Engine

class GridGraphTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }
    
    func testNeighborsExpectsZero() {
        let graph = GridGraph(width: 1, height: 1)
        let node = ValueNode(row: 0, col: 0, value: 0.0)
        graph.add(node: node)
        
        XCTAssertEqual(graph.neighbors(of: node).count, 0)
    }
    
    func testNeighborsExpectsThree() {
        let graph = GridGraph(width: 2, height: 2)
        let node = ValueNode(row: 0, col: 0, value: 0.0)
        
        graph.add(node: node)
        graph.add(node: ValueNode(row: 0, col: 1, value: 0.0))
        graph.add(node: ValueNode(row: 1, col: 0, value: 0.0))
        graph.add(node: ValueNode(row: 1, col: 1, value: 0.0))

        XCTAssertEqual(graph.neighbors(of: node).count, 3)
    }
    
    func testNeighborsExpectsFive() {
        // Make a 3x3 grid and put target node at top-middle,
        // which means we should have five neighbors.
        let graph = GridGraph(width: 3, height: 3)
        let node = ValueNode(row: 2, col: 1, value: 0.0)
        
        graph.add(node: node)
        graph.add(node: ValueNode(row: 0, col: 0, value: 0.0))
        graph.add(node: ValueNode(row: 0, col: 1, value: 0.0))
        graph.add(node: ValueNode(row: 0, col: 2, value: 0.0))
        graph.add(node: ValueNode(row: 1, col: 0, value: 0.0))
        graph.add(node: ValueNode(row: 1, col: 1, value: 0.0))
        graph.add(node: ValueNode(row: 1, col: 2, value: 0.0))
        graph.add(node: ValueNode(row: 2, col: 0, value: 0.0))
        graph.add(node: ValueNode(row: 2, col: 2, value: 0.0))
        
        XCTAssertEqual(graph.neighbors(of: node).count, 5)
    }
    
    func testNeighborsExpectsEight() {
        let graph = GridGraph(width: 3, height: 3)
        let node = ValueNode(row: 1, col: 1, value: 0.0)
        
        graph.add(node: node)
        graph.add(node: ValueNode(row: 0, col: 0, value: 0.0))
        graph.add(node: ValueNode(row: 0, col: 1, value: 0.0))
        graph.add(node: ValueNode(row: 0, col: 2, value: 0.0))
        graph.add(node: ValueNode(row: 1, col: 0, value: 0.0))
        graph.add(node: ValueNode(row: 1, col: 2, value: 0.0))
        graph.add(node: ValueNode(row: 2, col: 0, value: 0.0))
        graph.add(node: ValueNode(row: 2, col: 1, value: 0.0))
        graph.add(node: ValueNode(row: 2, col: 2, value: 0.0))
        
        XCTAssertEqual(graph.neighbors(of: node).count, 8)
    }

    func testFindPathScenario1() throws {
        let theme = Theme(id: 1, name: "Test Theme")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)

        let agent = Infantry1(game: game,
                              player: Player(playerId: 1, game: game),
                              theme: theme,
                              name: "Agent",
                              position: Position(row: 0, col: 0))
        let terrain = Terrain(id: -1,
                              tiledId: 0,
                              name: "None",
                              type: TerrainType.Grassland,
                              food: 0.0,
                              shields: 0.0,
                              trade: 0.0,
                              movementCost: 1.0)
        
        // Add 25 nodes to the map, all nodes have a uniform traversal score
        for row in 0..<3 {
            for col in 0..<3 {
                try map.add(tile: Tile(row: row, col: col, terrain: terrain))
            }
        }
        
        let graph = try agent.getPathfindingGraph(map: map)
        
        // Put our pathing agent at (0, 0), lower-left corner.  Make a target node
        // for pathing be (4, 4), upper-right corner.  Make sure that our optimal
        // path takes us diagonally up the map to the ultimate corner.
        if let start = graph.node(row: 0, col: 0),
           let end = graph.node(row: 2, col: 2) {
            
            let path = graph.findPath(start: start, end: end)
            
            XCTAssertEqual(path.count, 3)
            XCTAssertEqual(path[0], ValueNode(row: 0, col: 0, value: 0.0))
            XCTAssertEqual(path[1], ValueNode(row: 1, col: 1, value: 0.0))
            XCTAssertEqual(path[2], ValueNode(row: 2, col: 2, value: 0.0))
        }
    }
    
//    func testFindPathScenario2() {
//        let agent = Infantry1(playerId: 1, name: "Agent", row: 0, col: 0)
//        let enemy1 = Infantry1(playerId: 2, name: "Enemy1", row: 1, col: 1)
//        let enemy2 = Infantry1(playerId: 2, name: "Enemy2", row: 2, col: 1)
//        let terrain = Terrain(name: "test", food: 0.0, shields: 0.0, trade: 0.0, movementCost: 1.0)
//        let map = Map(width: 3, height: 3)
//
//        // Add 25 nodes to the map, all nodes have a uniform traversal score
//        for row in 0..<3 {
//            for col in 0..<3 {
//                map.add(tile: Tile(row: row, col: col, terrain: terrain))
//            }
//        }
//
//        // We are going to add
//        map.tile(row: 1, col: 1).addUnit(unit: enemy1)
//        map.tile(row: 2, col: 1).addUnit(unit: enemy2)
//
//        let graph = agent.getPathfindingGraph(map: map)
//        graph.log()
//
//        // Put our pathing agent at (0, 0), lower-left corner.  Make a target node
//        // for pathing be (4, 4), upper-right corner.  Make sure that our optimal
//        // path takes us diagonally up the map to the ultimate corner.
//        if let start = graph.node(row: 0, col: 0),
//           let end = graph.node(row: 2, col: 2) {
//
//            let path = graph.findPath(start: start, end: end)
//
//            // The path should go around the enemy at the center
//            XCTAssertEqual(path.count, 4)
//            XCTAssertEqual(path[0], ValueNode(row: 0, col: 0, value: 0.0))
//            XCTAssertEqual(path[1], ValueNode(row: 0, col: 1, value: 0.0))
//            XCTAssertEqual(path[2], ValueNode(row: 1, col: 2, value: 0.0))
//            XCTAssertEqual(path[3], ValueNode(row: 2, col: 2, value: 0.0))
//
//        }
//    }

}
