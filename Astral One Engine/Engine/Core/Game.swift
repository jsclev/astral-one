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

    public let turns: [Turn]
    public var players: [Player] = []
    public let map: Map
    public let theme: Theme
    public var commands: [Command] = []
    public let db: Db
    public var canvasSize = CGSize.zero
    
    public init(theme: Theme, map: Map, db: Db) throws {

        self.theme = theme
        self.map = map
        self.db = db
        self.turns = try self.db.turnDao.getTurns(theme: theme)
    }
    
    public func addPlayer(player: Player) {
        players.append(player)
    }
    
    public func addCommand(command: Command) {
        commands.append(command)
    }
    
    public func nextTurn() {
        if turnIndex < turns.count {
            turnIndex += 1
        }
    }
    
    public var currentPlayer: Player {
        return players[0]
    }
    
    public func getCurrentTurn() -> Turn {
        return turns[turnIndex]
    }
    
    public func processCommands() {
        while !commands.isEmpty {
            let _ = commands.removeLast().execute()
        }
    }
    
    public func select(mapPosition: Position) {
        self.selectedMapPosition = mapPosition
    }
}
