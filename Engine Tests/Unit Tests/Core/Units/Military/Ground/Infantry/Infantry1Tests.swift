import XCTest
import Engine

class Infantry1Tests: XCTestCase {
    func testCreateExpectsSuccess() throws {
        let fixture = Infantry1(playerId: 1,
                                name: "Infantry",
                                row: 0,
                                col: 0)
        XCTAssertEqual(10, fixture.cost)
        XCTAssertEqual(10, fixture.maxHp)
        XCTAssertEqual(10, fixture.currentHp)
        XCTAssertEqual(1, fixture.attackRating)
        XCTAssertEqual(1, fixture.defenseRating)
        XCTAssertEqual(1, fixture.maxMovementPoints)
        XCTAssertEqual(1, fixture.fp)
    }
    
    func testGetInfluenceMapUsingScenario1() throws {
        // We'll create a 5x5 map with an enemy infantry unit in the
        // exact center.  We'll put a unit in the lower-left corner at
        // position (0, 0).  The influence map should show the highest
        // negative level at the enemy position, then spreading out.
        let map = Map(width: 5, height: 5)
        let enemyUnit = Infantry1(playerId: 1, name: "Infantry", row: 2, col: 2)
        let agent = Infantry1(playerId: 2, name: "Infantry", row: 0, col: 0)
        let influenceMap = enemyUnit.getInfluenceMap(map: map, on: agent)
        
        agent.logInfluenceMap(theMap: influenceMap)
        
        // Make sure our influence map is the correct size
        XCTAssertEqual(influenceMap.count, 5)
        for i in 0..<5 {
            XCTAssertEqual(influenceMap[i].count, 5)
        }
        
        // Col 0
        XCTAssertEqual(influenceMap[0][0], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[0][1], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[0][2], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[0][3], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[0][4], -0.00001, accuracy: 0.00005)
        
        // Col 1
        XCTAssertEqual(influenceMap[1][0], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[1][1], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[1][2], -0.008, accuracy: 0.001)
        XCTAssertEqual(influenceMap[1][3], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[1][4], -0.00001, accuracy: 0.00005)
        
        // Col 2
        XCTAssertEqual(influenceMap[2][0], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[2][1], -0.008, accuracy: 0.001)
        XCTAssertEqual(influenceMap[2][2], -0.6, accuracy: 0.1)
        XCTAssertEqual(influenceMap[2][3], -0.008, accuracy: 0.001)
        XCTAssertEqual(influenceMap[2][4], -0.00001, accuracy: 0.00005)
        
        // Col 3
        XCTAssertEqual(influenceMap[3][0], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[3][1], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[3][2], -0.008, accuracy: 0.001)
        XCTAssertEqual(influenceMap[3][3], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[3][4], -0.00001, accuracy: 0.00005)
        
        // Col 4
        XCTAssertEqual(influenceMap[4][0], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[4][1], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[4][2], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[4][3], -0.00001, accuracy: 0.00005)
        XCTAssertEqual(influenceMap[4][4], -0.00001, accuracy: 0.00005)
    }
}
