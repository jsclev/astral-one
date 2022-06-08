import XCTest
import Engine

class Infantry1Tests: XCTestCase {
    func testCreateExpectsSuccess() throws {
        let theme = Theme(id: 1, name: "Test Theme")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map, db: TestUtils.getDb())

        let fixture = Infantry1(game: game,
                                player: Player(playerId: 1, game: game, map: map),
                                theme: theme,
                                name: "Infantry",
                                position: Position(row: 0, col: 0))
        XCTAssertEqual(10, fixture.cost)
        XCTAssertEqual(10, fixture.maxHp)
        XCTAssertEqual(10, fixture.currentHp)
        XCTAssertEqual(1, fixture.attack)
        XCTAssertEqual(1, fixture.defense)
        XCTAssertEqual(1, fixture.maxMovementPoints)
        XCTAssertEqual(1, fixture.fp)
    }
    
}
