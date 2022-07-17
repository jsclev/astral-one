import Foundation
import Combine
import CoreGraphics

public class Game: ObservableObject {
    @Published public var showFPS = false
    @Published public var numTaps = 0
    @Published public var tapLocation = CGPoint.zero
    @Published public var selectedMapPosition = Position(row: -1, col: -1)
    @Published public var selectedCityCreator: Settler?
    @Published public private (set) var currentPlayer: AIPlayer
    @Published public var turnIndex = 0
    @Published public var tileCoords = false
    @Published public var aiDebug = false

    public let gameId: Int
    public let turns: [Turn]
    public var players: [AIPlayer] = []
    public let map: Map
    public let theme: Theme
    public var commands: [Command] = []
    public let db: Db
    public var canvasSize = CGSize.zero
    public private (set) var currentPlayerIndex = 0
    
    public init(gameId: Int,
                theme: Theme,
                players: [AIPlayer],
                map: Map,
                db: Db) throws {
        self.gameId = gameId
        self.theme = theme
        self.map = map
        self.db = db
        self.turns = try self.db.turnDao.getTurns(theme: theme)
        self.currentPlayerIndex = 0
        self.players = players
        self.currentPlayer = players[0]
    }
    
    public func addCommand(command: Command) {
        commands.append(command)
    }
    
    public func endPlayerTurn() {
        if currentPlayerIndex == players.count - 1 {
            currentPlayerIndex = 0
            
            for player in players {
                for cityCreator in player.cityCreators {
                    cityCreator.movementPoints = cityCreator.maxMovementPoints
                }
                
                for unit in player.units {
                    unit.movementPoints = unit.maxMovementPoints
                }
            }
        }
        else {
            currentPlayerIndex += 1
        }
        
        if turnIndex < turns.count {
            turnIndex += 1
        }
            
        currentPlayer = players[currentPlayerIndex]
    }
    
    public var currentTurn: Turn {
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
    
    public func toggleTileCoords() {
        tileCoords = !tileCoords
    }
    
    public func toggleAIDebug() {
        aiDebug = !aiDebug
    }
}
