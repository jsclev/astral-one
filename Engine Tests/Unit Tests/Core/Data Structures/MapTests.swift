import XCTest
import Engine

class MapTests: XCTestCase {
    func testGetMoveCostsExpectsEmpty() throws {
        let map = Map(width: 1, height: 1)
        
        XCTAssertEqual(map.getMovementCosts().count, 1)
        XCTAssertEqual(map.getMovementCosts()[0].count, 1)
        
        XCTAssertEqual(map.getMovementCosts()[0][0], 0.0)
    }
    
    func testGetMoveCostsUsingGrass() throws {
        let map = Map(width: 1, height: 1)
        let tile = Tile(id: "1",
                        spec: TileDef(tileType: TileType.Terrain,
                                      terrainType: TerrainType.Grassland,
                                      unitType: UnitType.None),
                        ordinal: 0)
        map.addTile(row: 0, col: 0, tile: tile)
        
        XCTAssertEqual(map.getMovementCosts().count, 1)
        XCTAssertEqual(map.getMovementCosts()[0].count, 1)
        
        XCTAssertEqual(map.getMovementCosts()[0][0], 1.0)
    }
    
    func testGetMoveCostsUsingUnit() throws {
        let map = Map(width: 1, height: 1)
        let tile = Tile(id: "1",
                        spec: TileDef(tileType: TileType.Unit,
                                      terrainType: TerrainType.None,
                                      unitType: UnitType.Battleship),
                        ordinal: 0)
        map.addTile(row: 0, col: 0, tile: tile)
        
        XCTAssertEqual(map.getMovementCosts().count, 1)
        XCTAssertEqual(map.getMovementCosts()[0].count, 1)
        
        XCTAssertEqual(map.getMovementCosts()[0][0], 0.0)
    }

}
