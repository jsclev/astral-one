import XCTest
import Engine

class CommandDAOTests: XCTestCase {
    private var db = TestUtil.getDb()
    
    override func setUpWithError() throws {
        db = TestUtil.getDb()
    }
    
    func testInsertOneExpectsSuccess() throws {
        let player = Player(playerId: 1)
        let turn = Turn(id: 1, year: -4000, ordinal: 0, displayText: "4000 BCE")
        let commandType = CommandType(id: 1, name: "Move Unit")

        let unit = Engine.Unit(theme: Theme(id: 1, name: "Test Theme"),
                               playerId: 1,
                               tiledId: 1,
                               name: "Test",
                               assetName: "Test Asset Name",
                               cost: 0.0,
                               maxHp: 0.0,
                               attackRating: 0.0,
                               defense: 0.0,
                               fp: 0.0,
                               maxMovementPoints: 0.0,
                               position: Position(row: 0, col: 0))
        let fixture = MoveCommand(commandId: 1,
                                  gameId: 1,
                                  turn: turn,
                                  player: player,
                                  type: commandType,
                                  ordinal: 1,
                                  unit: unit,
                                  to: Position(row: 0, col: 0))
        
        let insertedCommands = try db.commandDao.insertMoveCommands(moveCommands: [fixture])
        
        XCTAssertGreaterThan(insertedCommands[0].commandId, 0)
        XCTAssertEqual(insertedCommands[0].gameId, 1)
        XCTAssertEqual(insertedCommands[0].turn.id, 1)
        XCTAssertEqual(insertedCommands[0].player.playerId, 1)
        XCTAssertEqual(insertedCommands[0].ordinal, 1)
    }
    
}
