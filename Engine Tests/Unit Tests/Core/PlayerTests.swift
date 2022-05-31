import XCTest
import Engine

class PlayerTests: XCTestCase {
    func testTechTree() throws {
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: Theme(id: 1, name: "Test Theme"), map: map)
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
        let game = Game(theme: Theme(id: 1, name: "Test Theme"), map: map)
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
