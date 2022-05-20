import XCTest
import Engine

class UnitTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
    }
    
    func testGetChebyshevDistance1() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        
        let fromUnit = Infantry1(game: game,
                                 player: Player(playerId: 1, game: game),
                                 theme: theme,
                                 name: "Infantry",
                                 position: Position(row: 0, col: 0))
        let toUnit = Infantry1(game: game,
                               player: Player(playerId: 1, game: game),
                               theme: theme,
                               name: "Infantry",
                               position: Position(row: 0, col: 0))
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 0)
    }
    
    func testGetChebyshevDistance2() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        
        let fromUnit = Infantry1(game: game,
                                 player: Player(playerId: 1, game: game),
                                 theme: theme,
                                 name: "Infantry",
                                 position: Position(row: 0, col: 0))
        let toUnit = Infantry1(game: game,
                               player: Player(playerId: 1, game: game),
                               theme: theme,
                               name: "Infantry",
                               position: Position(row: 0, col: 0))
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 1)
    }
    
    func testGetChebyshevDistance3() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        
        let fromUnit = Infantry1(game: game,
                                 player: Player(playerId: 1, game: game),
                                 theme: theme,
                                 name: "Infantry",
                                 position: Position(row: 0, col: 0))
        let toUnit = Infantry1(game: game,
                               player: Player(playerId: 1, game: game),
                               theme: theme,
                               name: "Infantry",
                               position: Position(row: 0, col: 0))
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 3)
    }
    
    func testGetChebyshevDistance4() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        
        let fromUnit = Infantry1(game: game,
                                 player: Player(playerId: 1, game: game),
                                 theme: theme,
                                 name: "Infantry",
                                 position: Position(row: 0, col: 0))
        let toUnit = Infantry1(game: game,
                               player: Player(playerId: 1, game: game),
                               theme: theme,
                               name: "Infantry",
                               position: Position(row: 0, col: 0))
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 4)
    }
    
    func testGetDefenseAgainstUsingGrass() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game)
        let position = Position(row: 0, col: 0)
        let enemyUnit = Infantry1(game: game,
                                  player: player,
                                  theme: theme,
                                  name: "Warrior",
                                  position: position)
        try map.add(tile: Tile(id: 1,
                               position: position,
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Grass",
                                                type: TerrainType.Grassland,
                                                food: 2.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 1.0,
                                                defenseBonus: 1.0)))
        player.add(city: City(player: player,
                              theme: theme,
                              name: "test unit",
                              assetName: "test asset name",
                              position: position))
        let unit = Infantry1(game: game,
                             player: player,
                             theme: theme,
                             name: "test unit",
                             position: position)
        player.add(unit: unit)
        
        XCTAssertEqual(unit.defense(against: enemyUnit), 1)
    }
    
    func testGetDefenseAgainstUsingMountain() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game)
        let position = Position(row: 0, col: 0)
        let enemyUnit = Infantry1(game: game,
                                  player: player,
                                  theme: theme,
                                  name: "Warrior",
                                  position: position)
        try map.add(tile: Tile(id: 1,
                               position: position,
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Mountain",
                                                type: TerrainType.Mountains,
                                                food: 0.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 0.0,
                                                defenseBonus: 0.0)))
        let city = City(player: player,
                        theme: theme,
                        name: "test unit",
                        assetName: "test asset name",
                        position: position)
        player.add(city: city)
        let unit = Infantry2(game: game,
                             player: player,
                             theme: theme,
                             name: "test unit",
                             position: position)
        unit.makeVeteran()
        player.add(unit: unit)
        
        XCTAssertEqual(unit.defense(against: enemyUnit), 9)
    }
    
    func getGetDefenseAgainstUsingXYZ() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 3, height: 3)
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game)
        // let turn1 = Turn(id: 1, year: -4000, ordinal: 1, displayText: "4000 BC")
        // let createUnitType = CommandType(id: 1, name: "Create Unit")
        // let moveUnitType = CommandType(id: 1, name: "Move Unit")
        
        
        //        try map.add(tile: Tile(id: 1,
        //                               row: 0,
        //                               col: 1,
        //                               terrain: Terrain(id: 1,
        //                                                tiledId: 1,
        //                                                name: "Forest",
        //                                                type: TerrainType.Forest,
        //                                                food: 1.0,
        //                                                shields: 2.0,
        //                                                trade: 0.0,
        //                                                movementCost: 2.0,
        //                                                defenseBonus: 1.5)))
        //        try map.add(tile: Tile(id: 1,
        //                               row: 0,
        //                               col: 2,
        //                               terrain: Terrain(id: 1,
        //                                                tiledId: 1,
        //                                                name: "Hills",
        //                                                type: TerrainType.Hills,
        //                                                food: 1.0,
        //                                                shields: 0.0,
        //                                                trade: 0.0,
        //                                                movementCost: 2.0,
        //                                                defenseBonus: 2.0)))
        //        try map.add(tile: Tile(id: 1,
        //                               row: 1,
        //                               col: 0,
        //                               terrain: Terrain(id: 1,
        //                                                tiledId: 1,
        //                                                name: "Mountain",
        //                                                type: TerrainType.Mountains,
        //                                                food: 0.0,
        //                                                shields: 1.0,
        //                                                trade: 0.0,
        //                                                movementCost: 3.0,
        //                                                defenseBonus: 3.0)))
        //        try map.add(tile: Tile(id: 1,
        //                               row: 1,
        //                               col: 1,
        //                               terrain: Terrain(id: 1,
        //                                                tiledId: 1,
        //                                                name: "Jungle",
        //                                                type: TerrainType.Jungle,
        //                                                food: 1.0,
        //                                                shields: 0.0,
        //                                                trade: 0.0,
        //                                                movementCost: 2.0,
        //                                                defenseBonus: 1.5)))
        //        try map.add(tile: Tile(id: 1,
        //                               row: 1,
        //                               col: 2,
        //                               terrain: Terrain(id: 1,
        //                                                tiledId: 1,
        //                                                name: "Swamp",
        //                                                type: TerrainType.Swamp,
        //                                                food: 1.0,
        //                                                shields: 0.0,
        //                                                trade: 0.0,
        //                                                movementCost: 2.0,
        //                                                defenseBonus: 1.5)))
        //        try map.add(tile: Tile(id: 1,
        //                               row: 2,
        //                               col: 0,
        //                               terrain: Terrain(id: 1,
        //                                                tiledId: 1,
        //                                                name: "Desert",
        //                                                type: TerrainType.Desert,
        //                                                food: 0.0,
        //                                                shields: 1.0,
        //                                                trade: 0.0,
        //                                                movementCost: 1.0,
        //                                                defenseBonus: 1.0)))
        //        try map.add(tile: Tile(id: 1,
        //                               row: 2,
        //                               col: 1,
        //                               terrain: Terrain(id: 1,
        //                                                tiledId: 1,
        //                                                name: "Plains",
        //                                                type: TerrainType.Plains,
        //                                                food: 1.0,
        //                                                shields: 1.0,
        //                                                trade: 0.0,
        //                                                movementCost: 1.0,
        //                                                defenseBonus: 1.0)))
        //        try map.add(tile: Tile(id: 1,
        //                               row: 2,
        //                               col: 2,
        //                               terrain: Terrain(id: 1,
        //                                                tiledId: 1,
        //                                                name: "Tundra",
        //                                                type: TerrainType.Tundra,
        //                                                food: 1.0,
        //                                                shields: 0.0,
        //                                                trade: 0.0,
        //                                                movementCost: 1.0,
        //                                                defenseBonus: 1.0)))
        
        
        let enemyUnit = Infantry1(game: game,
                                  player: player,
                                  theme: theme,
                                  name: "Warrior",
                                  position: Position(row: 0, col: 0))
        
        // Grass at [0, 0]
        var position = Position(row: 0, col: 0)
        try map.add(tile: Tile(id: 1,
                               position: position,
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Grass",
                                                type: TerrainType.Grassland,
                                                food: 2.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 1.0,
                                                defenseBonus: 1.0)))
        var playerCopy = player.clone()
        playerCopy.add(city: City(player: playerCopy,
                                  theme: theme,
                                  name: "test unit",
                                  assetName: "test asset name",
                                  position: position))
        var unit = Infantry1(game: game,
                             player: playerCopy,
                             theme: theme,
                             name: "test unit",
                             position: position)
        playerCopy.add(unit: unit)
        XCTAssertEqual(unit.defense(against: enemyUnit), 1)
    }
    
}
