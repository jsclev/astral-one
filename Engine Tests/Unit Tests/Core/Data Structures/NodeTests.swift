//import XCTest
//import Engine
//
//
//class NodeTests: XCTestCase {
//    func testMovementCostZeroTerrain() {
//        // Because A* has problems with 0 (zero) cost nodes, we
//        // want to make sure the minimum movement cost of any node
//        // will always be more than zero.
//
//        // Purposefully attempt to create a node with zero movement cost terrain
//        let tile = Tile(position: Position(row: 0, col: 0),
//                        terrain: Terrain(id: -1,
//                                         tiledId: 0,
//                                         name: "Grassland",
//                                         type: TerrainType.Grassland,
//                                         food: 0.0,
//                                         shields: 0.0,
//                                         trade: 0.0,
//                                         movementCost: 0.0,
//                                         defenseBonus: 1.0))
//        // Make sure the node's movement cost is greater than zero
//        XCTAssertEqual(tile.getMovementCost(), Constants.minMovementCost)
//    }
//
//    func testMovementCostNegTerrain() {
//        let tile = Tile(position: Position(row: 0, col: 0),
//                        terrain: Terrain(id: -1,
//                                         tiledId: 0,
//                                         name: "Grassland",
//                                         type: TerrainType.Grassland,
//                                         food: 0.0,
//                                         shields: 0.0,
//                                         trade: 0.0,
//                                         movementCost: -1.0,
//                                         defenseBonus: 1.0))
//
//        // Make sure the node's movement cost is greater than zero, even
//        // though we purposefully gave the terrain negative movement cost
//        XCTAssertEqual(tile.getMovementCost(), Constants.minMovementCost)
//    }
//
//    func testMovementCostNormalTerrain() {
//        let tile = Tile(position: Position(row: 0, col: 0),
//                        terrain: Terrain(id: -1,
//                                         tiledId: 0,
//                                         name: "Grassland",
//                                         type: TerrainType.Grassland,
//                                         food: 0.0,
//                                         shields: 0.0,
//                                         trade: 0.0,
//                                         movementCost: 1.0,
//                                         defenseBonus: 1.0))
//        XCTAssertEqual(tile.getMovementCost(), 1.0)
//    }
//
//    func testMovementCostModifier1() {
//        let tile = Tile(position: Position(row: 0, col: 0),
//                        terrain: Terrain(id: -1,
//                                         tiledId: 0,
//                                         name: "Grassland",
//                                         type: TerrainType.Grassland,
//                                         food: 0.0,
//                                         shields: 0.0,
//                                         trade: 0.0,
//                                         movementCost: -1.0,
//                                         defenseBonus: 1.0))
//        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0 / 3.0))
//
//        XCTAssertEqual(tile.getMovementCost(), 1.0 / 3.0)
//    }
//
//    func testMovementCostModifier2() {
//        let tile = Tile(position: Position(row: 0, col: 0),
//                        terrain: Terrain(id: -1,
//                                         tiledId: 0,
//                                         name: "Grassland",
//                                         type: TerrainType.Grassland,
//                                         food: 0.0,
//                                         shields: 0.0,
//                                         trade: 0.0,
//                                         movementCost: 0.0,
//                                         defenseBonus: 1.0))
//        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0 / 3.0))
//
//        XCTAssertEqual(tile.getMovementCost(), 1.0 / 3.0)
//    }
//
//    func testMovementCostModifier3() {
//        let tile = Tile(position: Position(row: 0, col: 0),
//                        terrain: Terrain(id: -1,
//                                         tiledId: 0,
//                                         name: "Grassland",
//                                         type: TerrainType.Grassland,
//                                         food: 0.0,
//                                         shields: 0.0,
//                                         trade: 0.0,
//                                         movementCost: 1.0,
//                                         defenseBonus: 1.0))
//        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0 / 3.0))
//
//        XCTAssertEqual(tile.getMovementCost(), 1.0 / 3.0)
//    }
//
//    func testMovementCostModifier4() {
//        let tile = Tile(position: Position(row: 0, col: 0),
//                        terrain: Terrain(id: -1,
//                                         tiledId: 0,
//                                         name: "Grassland",
//                                         type: TerrainType.Grassland,
//                                         food: 0.0,
//                                         shields: 0.0,
//                                         trade: 0.0,
//                                         movementCost: 100.0,
//                                         defenseBonus: 1.0))
//        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0 / 3.0))
//
//        XCTAssertEqual(tile.getMovementCost(), 1.0 / 3.0)
//    }
//
//    func testMovementCostModifier5() {
//        let tile = Tile(position: Position(row: 0, col: 0),
//                        terrain: Terrain(id: -1,
//                                         tiledId: 0,
//                                         name: "Grassland",
//                                         type: TerrainType.Grassland,
//                                         food: 0.0,
//                                         shields: 0.0,
//                                         trade: 0.0,
//                                         movementCost: 1000.0,
//                                         defenseBonus: 1.0))
//
//        tile.add(movementModifier: MovementModifier(name: "", movementCost: 1.0))
//        XCTAssertEqual(tile.getMovementCost(), 1.0)
//
//        tile.add(movementModifier: MovementModifier(name: "", movementCost: 3.0))
//        XCTAssertEqual(tile.getMovementCost(), 3.0)
//    }
//
//}
