import XCTest
import Engine

class TileTests: XCTestCase {
    func testBasicTileStats() throws {
        // Desert
        var tile = Tile(id: 1,
                        position: Position.zero,
                        terrain: Terrain(id: 1,
                                         tiledId: 1,
                                         name: "Test Tile",
                                         type: TerrainType.Desert))
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Forest
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Forest))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 2)
        XCTAssertEqual(tile.trade, 0)
        
        // Glacier
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Glacier))
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Grassland
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Grassland))
        XCTAssertEqual(tile.food, 2)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Hills
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Hills))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Jungle
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Jungle))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Mountains
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Mountains))
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Ocean
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Ocean))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 2)
        
        // Plains
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Plains))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Swamp
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Swamp))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Tundra
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Tundra))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
    }
    
    func testTileStatsUsingSpecialResources() throws {
        // Desert, Oasis
        var tile = Tile(id: 1,
                        position: Position.zero,
                        terrain: Terrain(id: 1,
                                         tiledId: 1,
                                         name: "Test Tile",
                                         type: TerrainType.Desert),
                        specialResource: SpecialResource.Oasis)
        XCTAssertEqual(tile.food, 3)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Desert, Oil
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Desert),
                    specialResource: SpecialResource.Oil)
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 4)
        XCTAssertEqual(tile.trade, 0)
        
        // Forest, Pheasant
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Forest),
                    specialResource: SpecialResource.Pheasant)
        XCTAssertEqual(tile.food, 3)
        XCTAssertEqual(tile.production, 2)
        XCTAssertEqual(tile.trade, 0)
        
        // Forest, Silk
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Forest),
                    specialResource: SpecialResource.Silk)
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 2)
        XCTAssertEqual(tile.trade, 3)
        
        // Glacier, Ivory
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Glacier),
                    specialResource: SpecialResource.Ivory)
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 4)
        
        // Glacier, Oil
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Glacier),
                    specialResource: SpecialResource.Oil)
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 4)
        XCTAssertEqual(tile.trade, 0)
        
        // Hills
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Hills),
                    specialResource: SpecialResource.Coal)
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 2)
        XCTAssertEqual(tile.trade, 0)
        
        // Hills
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Hills),
                    specialResource: SpecialResource.Wine)
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 4)
        
        // Jungle
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Jungle))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Mountains
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Mountains))
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Ocean
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Ocean))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 2)
        
        // Plains
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Plains))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Swamp
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Swamp))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Tundra
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Tundra))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
    }
}
