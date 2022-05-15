import XCTest
import Engine

class PlayerTests: XCTestCase {

    func testAddAvailable1() throws {
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: Theme(id: 1, name: "Test Theme"), map: map)
        let player = Player(playerId: 1, game: game)
        
        player.addAvailable(researchAction: ResearchAlphabetAction())
        let playerCopy = player.clone()
        
        for action in playerCopy.getAvailableActions() {
            action.execute(game: game, player: playerCopy)
        }
        
        XCTAssertEqual(player.defense, 0.001)
        XCTAssertEqual(playerCopy.defense, 0.001)
    }
    
    func testDefenseAgainstGroundAttacks() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game)
        
        // Initially the defense should be the minimum
        XCTAssertEqual(player.defenseAgainstGroundAttacks, Constants.minDefense)
        
        // Add a city and a military unit
        let city = City(player: player,
                        theme: theme,
                        name: "test city",
                        assetName: "test asset name",
                        position: Position(row: 0, col: 0))
        player.add(city: city)
        
        let createUnitAction = CreateInfantry1Action(city: city)
        createUnitAction.execute(game: game, player: player)
        
        // We should now have a single unit in the city
        XCTAssertEqual(player.units.count, 1)
        XCTAssertEqual(player.units[0].city, city)
        XCTAssertEqual(player.defenseAgainstGroundAttacks, 1.0)
        
        let buildWallsAction = BuildWallsAction(city: city)
        buildWallsAction.execute(game: game, player: player)
        
        // Defense against ground attacks should be 3x now
        XCTAssertEqual(player.defenseAgainstGroundAttacks, 3.0)
    }
    
}
