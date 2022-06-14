import XCTest
import Engine

class PlayerTests: XCTestCase {
    func testTechTree() throws {
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: Theme(id: 1, name: "Test Theme"), map: map, db: TestUtils.getDb())
        let player = Player(playerId: 1, game: game, map: map)
        
        XCTAssertFalse(player.get(advanceType: AdvanceType.Pottery).isResearching)
        XCTAssertFalse(player.get(advanceType: AdvanceType.Pottery).completed)
        
        player.startResearching(advanceType: AdvanceType.Pottery)
        
        XCTAssertTrue(player.get(advanceType: AdvanceType.Pottery).isResearching)
        XCTAssertFalse(player.get(advanceType: AdvanceType.Pottery).completed)
        
        player.completeResearch(advanceType: AdvanceType.Pottery)

        XCTAssertFalse(player.get(advanceType: AdvanceType.Pottery).isResearching)
        XCTAssertTrue(player.get(advanceType: AdvanceType.Pottery).completed)
    }
    
    func testTechTree2() throws {
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: Theme(id: 1, name: "Test Theme"), map: map, db: TestUtils.getDb())
        let player = Player(playerId: 1, game: game, map: map)
        
        XCTAssertFalse(player.get(advanceType: AdvanceType.Pottery).isResearching)
        XCTAssertFalse(player.get(advanceType: AdvanceType.Pottery).completed)
        
        player.startResearching(advanceType: AdvanceType.Pottery)
        
        XCTAssertTrue(player.get(advanceType: AdvanceType.Pottery).isResearching)
        XCTAssertFalse(player.get(advanceType: AdvanceType.Pottery).completed)
        
        player.completeResearch(advanceType: AdvanceType.Pottery)
        
        XCTAssertFalse(player.get(advanceType: AdvanceType.Pottery).isResearching)
        XCTAssertTrue(player.get(advanceType: AdvanceType.Pottery).completed)
    }
    
    func testGetTilesWithinCityRadius() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 5, height: 5)
        let game = Game(theme: theme, map: map, db: TestUtils.getDb())
        
        map.add(tile: TestUtils.makeTile(0, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 0, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 1, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 2, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 3, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 4, TerrainType.Grassland))
        
        map.revealAllTiles()
        
        let player = AIPlayer(playerId: 1,
                                game: game,
                                map: map,
                                skillLevel: SkillLevel.One,
                                difficultyLevel: DifficultyLevel.Easy,
                                playStyle: PlayStyle.init(offense: 0.5, defense: 0.5))
        
        // City radius from [0, 0]
        var cityRadius = player.getTilesInCityRadius(from: Position(row: 0, col: 0))
        XCTAssertEqual(8, cityRadius.count)
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 1))))
        
        // City radius from [1, 1]
        cityRadius = player.getTilesInCityRadius(from: Position(row: 1, col: 1))
        XCTAssertEqual(15, cityRadius.count)
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 3))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 3))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 3))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 2))))
        
        // City radius from [4, 4]
        cityRadius = player.getTilesInCityRadius(from: Position(row: 4, col: 4))
        XCTAssertEqual(8, cityRadius.count)
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 4, col: 4))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 4, col: 3))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 4, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 4))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 3))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 4))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 3))))
        
        // City radius from [2, 2]
        cityRadius = player.getTilesInCityRadius(from: Position(row: 2, col: 2))
        XCTAssertEqual(21, cityRadius.count)
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 0, col: 3))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 3))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 1, col: 4))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 3))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 2, col: 4))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 0))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 3))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 3, col: 4))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 4, col: 1))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 4, col: 2))))
        XCTAssertTrue(cityRadius.contains(map.tile(at: Position(row: 4, col: 3))))
    }
//    func testAddAvailable1() throws {
//        let map = Map(mapId: 1, width: 1, height: 1)
//        let game = Game(theme: Theme(id: 1, name: "Test Theme"), map: map)
//        let player = Player(playerId: 1, game: game)
//
//        player.addAvailable(researchAction: ResearchAlphabetAction())
//        let playerCopy = player.clone()
//
//        for action in playerCopy.getAvailableActions() {
//            action.execute(game: game, player: playerCopy)
//        }
//
//        XCTAssertEqual(player.defense, Constants.minDefense)
//        XCTAssertEqual(playerCopy.defense, Constants.minDefense)
//    }
//
//    func testDefenseAgainstGroundAttacks() throws {
//        let theme = Theme(id: 1, name: "Standard")
//        let map = Map(mapId: 1, width: 1, height: 1)
//        let game = Game(theme: theme, map: map)
//        let player = Player(playerId: 1, game: game)
//
//        // Add a city and a military unit
//        let city = City(player: player,
//                        theme: theme,
//                        name: "test city",
//                        assetName: "test asset name",
//                        position: Position(row: 0, col: 0))
//        player.add(city: city)
//
//        let createUnitAction = CreateInfantry1Action()
//        let buildWallsAction = BuildCityWallsAction(city: city)
//
//        // Initially the defense should be the minimum
//        XCTAssertEqual(player.defenseAgainstGroundAttacks, Constants.minDefense)
//
//        // Add a single unit to the city
//        createUnitAction.execute(game: game, player: player)
//        XCTAssertEqual(player.units.count, 1)
//        XCTAssertEqual(player.units[0].city, city)
//        XCTAssertEqual(player.defenseAgainstGroundAttacks, 1.0)
//
//        // Add walls to the city and make sure the defense against ground attacks increased
//        buildWallsAction.execute(game: game, player: player)
//        XCTAssertEqual(player.defenseAgainstGroundAttacks, 3.0)
//    }
//
//    func testClone1() throws {
//        let theme = Theme(id: 1, name: "Standard")
//        let map = Map(mapId: 1, width: 1, height: 1)
//        let game = Game(theme: theme, map: map)
//        let player = Player(playerId: 1, game: game)
//
//        // Add a city and a military unit
//        let city = City(player: player,
//                        theme: theme,
//                        name: "test city",
//                        assetName: "test asset name",
//                        position: Position(row: 0, col: 0))
//        player.add(city: city)
//
//        let createUnitAction = CreateInfantry1Action()
//        let buildWallsAction = BuildCityWallsAction(city: city)
//
//        let playerClone = player.clone()
//
//        // Initially the defense should be the minimum
//        XCTAssertEqual(playerClone.cities.count, 1)
//
//        // Add a single unit to the city
////        createUnitAction.execute(game: game, player: player)
////        XCTAssertEqual(player.units.count, 1)
////        XCTAssertEqual(player.units[0].city, city)
//        XCTAssertEqual(player.getAvailableActions().count, 2)
//
//        // Add walls to the city and make sure the defense against ground attacks increased
////        buildWallsAction.execute(game: game, player: player)
////        XCTAssertEqual(player.defenseAgainstGroundAttacks, 3.0)
//    }
//
}
