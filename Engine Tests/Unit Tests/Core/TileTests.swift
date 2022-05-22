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
                                         type: TerrainType.Desert,
                                         food: 0.0,
                                         shields: 0.0,
                                         trade: 0.0,
                                         movementCost: 0.0,
                                         defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Forest
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Forest,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 2)
        XCTAssertEqual(tile.trade, 0)
        
        // Glacier
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Glacier,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Grassland
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Grassland,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 2)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Hills
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Hills,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Jungle
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Jungle,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Mountains
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Mountains,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Ocean
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Ocean,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 2)
        
        // Plains
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Plains,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Swamp
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Swamp,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Tundra
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Tundra,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
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
                                         type: TerrainType.Desert,
                                         food: 0.0,
                                         shields: 0.0,
                                         trade: 0.0,
                                         movementCost: 0.0,
                                         defenseBonus: 0.0),
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
                                     type: TerrainType.Desert,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0),
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
                                     type: TerrainType.Forest,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0),
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
                                     type: TerrainType.Forest,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0),
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
                                     type: TerrainType.Glacier,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0),
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
                                     type: TerrainType.Glacier,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0),
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
                                     type: TerrainType.Hills,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0),
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
                                     type: TerrainType.Hills,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0),
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
                                     type: TerrainType.Jungle,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Mountains
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Mountains,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 0)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Ocean
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Ocean,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 2)
        
        // Plains
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Plains,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 1)
        XCTAssertEqual(tile.trade, 0)
        
        // Swamp
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Swamp,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
        // Tundra
        tile = Tile(id: 1,
                    position: Position.zero,
                    terrain: Terrain(id: 1,
                                     tiledId: 1,
                                     name: "Test Tile",
                                     type: TerrainType.Tundra,
                                     food: 0.0,
                                     shields: 0.0,
                                     trade: 0.0,
                                     movementCost: 0.0,
                                     defenseBonus: 0.0))
        XCTAssertEqual(tile.food, 1)
        XCTAssertEqual(tile.production, 0)
        XCTAssertEqual(tile.trade, 0)
        
    }
}
