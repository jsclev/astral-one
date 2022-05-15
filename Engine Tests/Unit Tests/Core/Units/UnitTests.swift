import XCTest
import Engine

class UnitTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
    }
    
    func testGetChebyshevDistance1() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        
        let fromUnit = Infantry1(game: game,
                                 player: Player(playerId: 1, game: game),
                                 theme: theme,
                                 name: "Infantry",
                                 position: Position(row: 0, col: 0))
        let toUnit = Infantry1(game: game,
                               player: Player(playerId: 1, game: game),
                               theme: theme,
                               name: "Infantry",
                               position: Position(row: 0, col: 0))
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 0)
    }
    
    func testGetChebyshevDistance2() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        
        let fromUnit = Infantry1(game: game,
                                 player: Player(playerId: 1, game: game),
                                 theme: theme,
                                 name: "Infantry",
                                 position: Position(row: 0, col: 0))
        let toUnit = Infantry1(game: game,
                               player: Player(playerId: 1, game: game),
                               theme: theme,
                               name: "Infantry",
                               position: Position(row: 0, col: 0))
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 1)
    }
    
    func testGetChebyshevDistance3() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)

        let fromUnit = Infantry1(game: game,
                                 player: Player(playerId: 1, game: game),
                                 theme: theme,
                                 name: "Infantry",
                                 position: Position(row: 0, col: 0))
        let toUnit = Infantry1(game: game,
                               player: Player(playerId: 1, game: game),
                               theme: theme,
                               name: "Infantry",
                               position: Position(row: 0, col: 0))
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 3)
    }
    
    func testGetChebyshevDistance4() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)

        let fromUnit = Infantry1(game: game,
                                 player: Player(playerId: 1, game: game),
                                 theme: theme,
                                 name: "Infantry",
                                 position: Position(row: 0, col: 0))
        let toUnit = Infantry1(game: game,
                               player: Player(playerId: 1, game: game),
                               theme: theme,
                               name: "Infantry",
                               position: Position(row: 0, col: 0))
        
        XCTAssertEqual(fromUnit.getChebyshevDistance(to: toUnit), 4)
    }
    
    

}
