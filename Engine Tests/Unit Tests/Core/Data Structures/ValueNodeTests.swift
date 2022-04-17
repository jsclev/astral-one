import XCTest
import Engine

class ValueNodeTests: XCTestCase {
    func testEqualsExpectsTrue1() throws {
        let lhs = ValueNode(row: 0, col: 0, value: 0.0)
        let rhs = ValueNode(row: 0, col: 0, value: 0.0)

        XCTAssertEqual(lhs, rhs)
    }

    func testEqualsExpectsTrue2() throws {
        let lhs = ValueNode(row: 0, col: 0, value: 0.0)
        let rhs = ValueNode(row: 0, col: 0, value: 1.0)
        
        XCTAssertEqual(lhs, rhs)
    }
}
