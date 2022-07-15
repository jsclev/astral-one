import Foundation
import Combine
import CoreGraphics

public class Game: ObservableObject {
    @Published public var showFPS = false
    @Published public var numTaps = 0
    @Published public var tapLocation = CGPoint.zero
    @Published public var selectedMapPosition = Position(row: -1, col: -1)
    @Published public var selectedCityCreator: Settler?
    @Published public var turnIndex = 0
    @Published public var aiDebug = false

    public let gameId: Int
    public let turns: [Turn]
    public var players: [AIPlayer] = []
    public let map: Map
    public let theme: Theme
    public var commands: [Command] = []
    public let db: Db
    public var canvasSize = CGSize.zero
    
    public init(gameId: Int, theme: Theme, map: Map, db: Db) throws {
        self.gameId = gameId
        self.theme = theme
        self.map = map
        self.db = db
        self.turns = try self.db.turnDao.getTurns(theme: theme)
    }
    
    public func addPlayer(aiPlayer: AIPlayer) {
        players.append(aiPlayer)
    }
    
    public func addCommand(command: Command) {
        commands.append(command)
    }
    
    public func nextTurn() {
        if turnIndex < turns.count {
            turnIndex += 1
        }
    }
    
    public var currentPlayer: AIPlayer {
        return players[0]
    }
    
    public func getCurrentTurn() -> Turn {
        return turns[turnIndex]
    }
    
    public func processCommands() {
        while !commands.isEmpty {
            let _ = commands.removeLast().execute(save: true)
        }
    }
    
    public func select(mapPosition: Position) {
        self.selectedMapPosition = mapPosition
    }
    
    public func toggleAIDebug() {
        aiDebug = !aiDebug
    }
    
    public func placeInitialSettlers() {
        let position = Position(row: (currentPlayer.map.height / 2) - 1,
                                col: (currentPlayer.map.width / 2) - 1)
        let cmd = CreateSettlerCommand(player: currentPlayer,
                                       turn: getCurrentTurn(),
                                       ordinal: getCurrentTurn().ordinal,
                                       cost: 1,
                                       tile: currentPlayer.map.tile(at: position))
        let _ = cmd.execute(save: true)
    }
}
