import XCTest
import Astral_One_Engine

class CommandDAOTests: XCTestCase {
    private var db = TestUtil.getDb()
    
    override func setUpWithError() throws {
        db = TestUtil.getDb()
    }
    
//    func testInsertNoneExpectsSuccess() throws {
//        XCTAssertEqual(db.commandDao.getCommands(gameId: 1).count, 0)
//    }
    
    func testInsertOneExpectsSuccess() throws {
        let turn = Turn(id: 1,
                        year: -4000,
                        ordinal: 0,
                        displayText: "4000 BCE")
        let commandType = CommandType(id: 1,
                                      name: "Move Unit")
        
        let fixture = MoveCommand(commandId: 1,
                                  gameId: 1,
                                  turn: turn,
                                  playerId: 1,
                                  type: commandType,
                                  ordinal: 1,
                                  unit: Unit(name: "Settler", maxHP: 10),
                                  toPosition: "Hello")
        
        let actual = try db.commandDao.insertMoveCommand(moveCommand: fixture)
        
        XCTAssertEqual(actual.commandId, 1)
        XCTAssertEqual(actual.gameId, 1)
        XCTAssertEqual(actual.turn.id, 1)
        XCTAssertEqual(actual.playerId, 1)
        XCTAssertEqual(actual.ordinal, 1)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
