import XCTest
import Engine

class UnitInfluenceMapCalculatorTests: XCTestCase {
    func testGetInfluenceMapScenario1() throws {
        // Create a 3x3 map and place an agent in the lower-left
        // corner.  We'll create an enemy unit, but won't actually
        // add it to the map, and assert that the influence is zero.
        let map = Map(mapId: 1, width: 3, height: 3)
        let theme = Theme(id: 1, name: "Standard")
        let game = Game(theme: theme, map: map)
        
        let agent = Infantry1(game: game,
                              player: Player(playerId: 1, game: game, map: map),
                              theme: theme,
                              name: "Test",
                              position: Position(row: 0, col: 0))
        let enemyUnit = Infantry1(game: game,
                                  player: Player(playerId: 1, game: game, map: map),
                                  theme: theme,
                                  name: "Test",
                                  position: Position(row: 1, col: 1))

        let calculator = UnitInfluenceMapCalculator(map: map, unit: enemyUnit, agent: agent)
        let influenceMap = try calculator.getInfluenceMap()

        // calculator.logInfluenceMap(theMap: influenceMap)

        // Col 0
        XCTAssertEqual(influenceMap[0][0], 0.0, accuracy: 0.01)
        XCTAssertEqual(influenceMap[0][1], 0.0, accuracy: 0.01)
        XCTAssertEqual(influenceMap[0][2], 0.0, accuracy: 0.01)

        // Col 1
        XCTAssertEqual(influenceMap[1][0], 0.0, accuracy: 0.01)
        XCTAssertEqual(influenceMap[1][1], 0.0, accuracy: 0.01)
        XCTAssertEqual(influenceMap[1][2], 0.0, accuracy: 0.01)

        // Col 2
        XCTAssertEqual(influenceMap[2][0], 0.0, accuracy: 0.01)
        XCTAssertEqual(influenceMap[2][1], 0.0, accuracy: 0.01)
        XCTAssertEqual(influenceMap[2][2], 0.0, accuracy: 0.01)
    }
    
    func testGetInfluenceMapScenario2() throws {
        // Create a 3x3 map with an enemy infantry unit in the
        // exact center.  We'll put an agent in the lower-left corner at
        // position (0, 0).  The influence map should show the highest
        // negative level at the enemy position, then spreading out.
        let map = Map(mapId: 1, width: 3, height: 3)
        let theme = Theme(id: 1, name: "Test Theme")
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game, map: map)
        let enemyPlayer = Player(playerId: 2, game: game, map: map)
        
        let agent = Infantry1(game: game,
                              player: player,
                              theme: theme,
                              name: "Test",
                              position: Position(row: 0, col: 0))
        player.add(unit: agent)
        
        let enemyUnit = Infantry1(game: game,
                                  player: enemyPlayer,
                                  theme: theme,
                                  name: "Test",
                                  position: Position(row: 0, col: 0))
        enemyPlayer.add(unit: enemyUnit)
        
        let tile = Tile(position: Position(row: 1, col: 1),
                        terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland))
        map.add(tile: tile)
        
        let calculator = UnitInfluenceMapCalculator(map: map, unit: enemyUnit, agent: agent)
        let influenceMap = try calculator.getInfluenceMap()
        
        //calculator.logInfluenceMap(theMap: influenceMap)
        
        // Make sure our influence map is the correct size
        XCTAssertEqual(influenceMap.count, 3)
        for i in 0..<3 {
            XCTAssertEqual(influenceMap[i].count, 3)
        }
        
        // Make sure the 8 locations around the edge are the same
        XCTAssertEqual(influenceMap[0][0], -0.25, accuracy: 0.1)
        XCTAssertEqual(influenceMap[0][0], influenceMap[0][1])
        XCTAssertEqual(influenceMap[0][0], influenceMap[0][2])
        XCTAssertEqual(influenceMap[0][0], influenceMap[1][0])
        XCTAssertEqual(influenceMap[0][0], influenceMap[1][2])
        XCTAssertEqual(influenceMap[0][0], influenceMap[2][0])
        XCTAssertEqual(influenceMap[0][0], influenceMap[2][1])
        XCTAssertEqual(influenceMap[0][0], influenceMap[2][2])

        // The only location that should be more negative is the enemy unit location
        XCTAssertLessThan(influenceMap[1][1], influenceMap[0][0])
    }
    
    func testGetInfluenceMapScenario3() throws {
        /*
         Create a 3x3 map, and put an agent in the lower-left corner at (0, 0). Put two
         enemy units in the center at (1, 1) and check the influence maps from each enemy
         unit, and make sure the influence map from the more powerful enemy unit has a higher
         negative influence.
         */
        let map = Map(mapId: 1, width: 3, height: 3)
        let theme = Theme(id: 1, name: "Test Theme")
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game, map: map)
        let enemyPlayer = Player(playerId: 2, game: game, map: map)

        let agent = Infantry1(game: game,
                              player: player,
                              theme: theme,
                              name: "Agent",
                              position: Position(row: 0, col: 0))
        player.add(unit: agent)
        
        let enemyUnit1 = Infantry1(game: game,
                                   player: enemyPlayer,
                                   theme: theme,
                                   name: "Enemy1",
                                   position: Position(row: 1, col: 1))
        enemyPlayer.add(unit: enemyUnit1)
        
        let enemyUnit2 = Cavalry7(game: game,
                                  player: enemyPlayer,
                                  theme: theme,
                                  name: "Enemy2",
                                  position: Position(row: 1, col: 1))
        enemyPlayer.add(unit: enemyUnit2)

        let tile = Tile(position: Position(row: 1, col: 1),
                        terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland))
        map.add(tile: tile)
        
        let calculator1 = UnitInfluenceMapCalculator(map: map, unit: enemyUnit1, agent: agent)
        let influenceMap1 = try calculator1.getInfluenceMap()
        calculator1.logInfluenceMap(theMap: influenceMap1)
        
        let calculator2 = UnitInfluenceMapCalculator(map: map, unit: enemyUnit2, agent: agent)
        let influenceMap2 = try calculator2.getInfluenceMap()
        calculator2.logInfluenceMap(theMap: influenceMap2)

        // Make sure the 2nd more powerful enemy unit has a higher negative value
        XCTAssertLessThan(influenceMap2[0][0], influenceMap1[0][0])
        XCTAssertLessThan(influenceMap2[0][1], influenceMap1[0][1])
        XCTAssertLessThan(influenceMap2[0][2], influenceMap1[0][2])
        XCTAssertLessThan(influenceMap2[1][0], influenceMap1[1][0])
        XCTAssertLessThan(influenceMap2[1][1], influenceMap1[1][1])
        XCTAssertLessThan(influenceMap2[1][2], influenceMap1[1][2])
        XCTAssertLessThan(influenceMap2[2][0], influenceMap1[2][0])
        XCTAssertLessThan(influenceMap2[2][1], influenceMap1[2][1])
        XCTAssertLessThan(influenceMap2[2][2], influenceMap1[2][2])
    }
    
    func testSumScenario1() throws {
        /*
         Create a 3x3 map, and put an agent in the lower-left corner at (0, 0). Put two
         enemy units in the center at (1, 1) and check the influence maps from each enemy
         unit, and make sure the influence map from the more powerful enemy unit has a higher
         negative influence.
         */
        let mainMap = Map(mapId: 1, width: 3, height: 3)
        let theme = Theme(id: 1, name: "Test Theme")
        let game = Game(theme: theme, map: mainMap)
        let player = Player(playerId: 1, game: game, map: mainMap)
        let enemyPlayer = Player(playerId: 2, game: game, map: mainMap)
        
        let agent = Infantry1(game: game,
                              player: Player(playerId: 1, game: game, map: mainMap),
                              theme: theme,
                              name: "Agent",
                              position: Position(row: 0, col: 0))
        player.add(unit: agent)
        
        let enemyUnit1 = Infantry1(game: game,
                                   player: Player(playerId: 1, game: game, map: mainMap),
                                   theme: theme,
                                   name: "Enemy1",
                                   position: Position(row: 0, col: 0))
        enemyPlayer.add(unit: enemyUnit1)
        
        let enemyUnit2 = Cavalry7(game: game,
                                  player: Player(playerId: 1, game: game, map: mainMap),
                                  theme: theme,
                                  name: "Enemy2",
                                  position: Position(row: 0, col: 0))
        enemyPlayer.add(unit: enemyUnit2)
        
        let tile = Tile(position: Position(row: 1, col: 1),
                        terrain: try TerrainFactory.create(terrainType: TerrainType.Grassland))
        mainMap.add(tile: tile)
        
        let calculator1 = UnitInfluenceMapCalculator(map: mainMap, unit: enemyUnit1, agent: agent)
        let map1 = try calculator1.getInfluenceMap()
        calculator1.logInfluenceMap(theMap: map1)
        
        let calculator2 = UnitInfluenceMapCalculator(map: mainMap, unit: enemyUnit2, agent: agent)
        let map2 = try calculator2.getInfluenceMap()
        calculator2.logInfluenceMap(theMap: map2)
        
        let map3 = UnitInfluenceMapCalculator.sum(map1: map1, map2: map2)
        
        // Make sure the 2nd more powerful enemy unit has a higher negative value
        XCTAssertEqual(map3[0][0], map1[0][0] + map2[0][0])
        XCTAssertEqual(map3[0][1], map1[0][1] + map2[0][1])
        XCTAssertEqual(map3[0][2], map1[0][2] + map2[0][2])
        XCTAssertEqual(map3[1][0], map1[1][0] + map2[1][0])
        XCTAssertEqual(map3[1][1], map1[1][1] + map2[1][1])
        XCTAssertEqual(map3[1][2], map1[1][2] + map2[1][2])
        XCTAssertEqual(map3[2][0], map1[2][0] + map2[2][0])
        XCTAssertEqual(map3[2][1], map1[2][1] + map2[2][1])
        XCTAssertEqual(map3[2][2], map1[2][2] + map2[2][2])

        XCTAssertLessThan(map3[0][0], 0)
    }

}
