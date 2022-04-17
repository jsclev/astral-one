import XCTest
import Engine

class UnitTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
    }
    
    func testGetChebyshevDistance1() throws {
        let fromUnit = Infantry1(playerId: 1, name: "Infantry", row: 0, col: 0)
        let toUnit = Infantry1(playerId: 1, name: "Infantry", row: 0, col: 0)
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 0)
    }
    
    func testGetChebyshevDistance2() throws {
        let fromUnit = Infantry1(playerId: 1, name: "Infantry", row: 0, col: 0)
        let toUnit = Infantry1(playerId: 1, name: "Infantry", row: 0, col: 1)
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 1)
    }
    
    func testGetChebyshevDistance3() throws {
        let fromUnit = Infantry1(playerId: 1, name: "Infantry", row: 0, col: 0)
        let toUnit = Infantry1(playerId: 1, name: "Infantry", row: 3, col: 3)
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 3)
    }
    
    func testGetChebyshevDistance4() throws {
        let fromUnit = Infantry1(playerId: 1, name: "Infantry", row: 0, col: 0)
        let toUnit = Infantry1(playerId: 1, name: "Infantry", row: 2, col: 4)
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 4)
    }
    
    

}
