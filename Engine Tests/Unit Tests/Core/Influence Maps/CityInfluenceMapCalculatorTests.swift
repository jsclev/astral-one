import XCTest
import Engine

class CityInfluenceMapCalculatorTests: XCTestCase {
    func testUsingMapSize5() throws {
        // We'll create a 5x5 map, put a city in the exact center,
        // and place an enemy unit at (0, 0).  We'll expect the city's
        // influence map to have a negative influence over the 3x3 grid
        // in the center of the map.
        let fixture = CityInfluenceMapCalculator(map: Map(width: 5,
                                                          height: 5),
                                                 city: City(playerId: 1,
                                                            name: "New York",
                                                            row: 2,
                                                            col: 2),
                                                 unit: Infantry1(playerId: 2,
                                                                 name: "Infantry",
                                                                 row: 0,
                                                                 col: 0))
        let influenceMap = fixture.getInfluenceMap()
        XCTAssertEqual(influenceMap.count, 5)
        
        // Row 0
        XCTAssertEqual(influenceMap[0][0], 0.0)
        XCTAssertEqual(influenceMap[0][1], 0.0)
        XCTAssertEqual(influenceMap[0][2], 0.0)
        XCTAssertEqual(influenceMap[0][3], 0.0)
        XCTAssertEqual(influenceMap[0][4], 0.0)

        // Row 1
        XCTAssertEqual(influenceMap[1][0], 0.0)
        XCTAssertEqual(influenceMap[1][1], -10.0)
        XCTAssertEqual(influenceMap[1][2], -10.0)
        XCTAssertEqual(influenceMap[1][3], -10.0)
        XCTAssertEqual(influenceMap[1][4], 0.0)
        
        // Row 2
        XCTAssertEqual(influenceMap[2][0], 0.0)
        XCTAssertEqual(influenceMap[2][1], -10.0)
        XCTAssertEqual(influenceMap[2][2], -10.0)
        XCTAssertEqual(influenceMap[2][3], -10.0)
        XCTAssertEqual(influenceMap[2][4], 0.0)
        
        // Row 3
        XCTAssertEqual(influenceMap[3][0], 0.0)
        XCTAssertEqual(influenceMap[3][1], -10.0)
        XCTAssertEqual(influenceMap[3][2], -10.0)
        XCTAssertEqual(influenceMap[3][3], -10.0)
        XCTAssertEqual(influenceMap[3][4], 0.0)
        
        // Row 4
        XCTAssertEqual(influenceMap[4][0], 0.0)
        XCTAssertEqual(influenceMap[4][1], 0.0)
        XCTAssertEqual(influenceMap[4][2], 0.0)
        XCTAssertEqual(influenceMap[4][3], 0.0)
        XCTAssertEqual(influenceMap[4][4], 0.0)
    }
}
