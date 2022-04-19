import XCTest
import Engine

class CommandDAOTests: XCTestCase {
    private var db = TestUtil.getDb()
    
    override func setUpWithError() throws {
        db = TestUtil.getDb()
    }
    
    func testInsertOneExpectsSuccess() throws {
        let turn = Turn(id: 1,
                        year: -4000,
                        ordinal: 0,
                        displayText: "4000 BCE")
        let commandType = CommandType(id: 1,
                                      name: "Move Unit")
        let unit = Engine.Unit(playerId: 1,
                               name: "Test",
                               cost: 0.0,
                               maxHp: 0.0,
                               attackRating: 0.0,
                               defenseRating: 0.0,
                               fp: 0.0,
                               maxMovementPoints: 0.0,
                               row: 0,
                               col: 0)
        let fixture = MoveCommand(commandId: 1,
                                  gameId: 1,
                                  turn: turn,
                                  playerId: 1,
                                  type: commandType,
                                  ordinal: 1,
                                  unit: unit,
                                  toPosition: "Hello")
        
        let insertedCommands = try db.commandDao.insertMoveCommands(moveCommands: [fixture])
        
        XCTAssertGreaterThan(insertedCommands[0].commandId, 0)
        XCTAssertEqual(insertedCommands[0].gameId, 1)
        XCTAssertEqual(insertedCommands[0].turn.id, 1)
        XCTAssertEqual(insertedCommands[0].playerId, 1)
        XCTAssertEqual(insertedCommands[0].ordinal, 1)
    }
    
}
