import XCTest
import Engine

class Infantry1Tests: XCTestCase {
    func testCreateExpectsSuccess() throws {
        let fixture = Infantry1(playerId: 1,
                                name: "Infantry",
                                row: 0,
                                col: 0)
        XCTAssertEqual(10, fixture.cost)
        XCTAssertEqual(10, fixture.hp)
        XCTAssertEqual(10, fixture.currentHp)
        XCTAssertEqual(1, fixture.attackRating)
        XCTAssertEqual(1, fixture.defenseRating)
        XCTAssertEqual(1, fixture.movementPoints)
        XCTAssertEqual(1, fixture.firepower)
    }
}
