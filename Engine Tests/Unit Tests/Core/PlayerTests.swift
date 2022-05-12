import XCTest
import Engine

class PlayerTests: XCTestCase {

    func testAddAvailable1() throws {
        let planner = Planner()
        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
        let player = Player(playerId: 1)
        
        player.addAvailable(action: CreateInfantry1Action())
        let playerCopy = player.clone()
        
        for action in playerCopy.availableActions {
            action.execute(game: game, player: playerCopy)
        }
        
        XCTAssertEqual(player.defense, 0.001)
        XCTAssertEqual(playerCopy.defense, 1)
    }

}
