import XCTest
import Engine

class GridGraphTests: XCTestCase {
    func testCreateExpectsSuccess() throws {
        let gridGraph = GridGraph(width: 1, height: 1)
        
        XCTAssertEqual(gridGraph.width, 1)
        XCTAssertEqual(gridGraph.height, 1)
    }
}
