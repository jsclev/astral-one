import XCTest
import Engine

class CommandDAOTests: XCTestCase {
    private var db = TestUtil.getDb()
    
    override func setUpWithError() throws {
        db = TestUtil.getDb()
    }
    
    func testInsertOneExpectsSuccess() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game)
        let turn = Turn(id: 1, year: -4000, ordinal: 0, displayText: "4000 BCE")
        let commandType = CommandType(id: 1, name: "Move Unit")

        let unit = Engine.Unit(game: game,
                               player: player,
                               theme: theme,
                               tiledId: 1,
                               name: "Test",
                               assetName: "Test Asset Name",
                               cost: 0.0,
                               maxHp: 0.0,
                               attack: 0.0,
                               defense: 0.0,
                               fp: 0.0,
                               maxMovementPoints: 0.0,
                               position: Position(row: 0, col: 0))
        let fixture = MoveCommand(commandId: 1,
                                  game: game,
                                  turn: turn,
                                  player: player,
                                  type: commandType,
                                  ordinal: 1,
                                  unit: unit,
                                  to: Position(row: 0, col: 0))
        
        let insertedCommands = try db.commandDao.insertMoveCommands(moveCommands: [fixture])
        
        XCTAssertGreaterThan(insertedCommands[0].commandId, 0)
        XCTAssertEqual(insertedCommands[0].turn.id, 1)
        XCTAssertEqual(insertedCommands[0].player.playerId, 1)
        XCTAssertEqual(insertedCommands[0].ordinal, 1)
    }
    
}
