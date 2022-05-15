import XCTest
import Engine

class CityTests: XCTestCase {
    func testCreateBarracks() throws {
        let theme = Theme(id: 1, name: "test theme")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game)
        
        let city = City(player: player,
                        theme: theme,
                        name: "test city",
                        assetName: "city",
                        position: Position(row: 0, col: 0))
        
        let buildBarracksAction = BuildBarracksAction(city: city)
        let createUnitAction = CreateInfantry2Action(city: city)
        
        // At this point, the player should have zero units
        XCTAssertEqual(player.units.count, 0)
        XCTAssertFalse(city.hasBarracks)

        // Since the city has a Barracks, the unit should already have Veteran status.
        // The infantry2 (Phalanx) starts out by default with defense of 2, so Veteran
        // status should result in a defense of 3.
        buildBarracksAction.execute(game: game, player: player)
        createUnitAction.execute(game: game, player: player)

        XCTAssertEqual(player.units.count, 1)
        XCTAssertEqual(player.units[0].attack, 1)
        XCTAssertEqual(player.units[0].defense, 3)
    }

}
