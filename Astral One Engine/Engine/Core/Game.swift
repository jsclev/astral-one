import Foundation
import Combine
import CoreGraphics

public class Game: ObservableObject {
    @Published public var showFPS = false
    @Published public var numTaps = 0
    @Published public var tapLocation = CGPoint.zero
    @Published public var selectedMapPosition = Position(row: -1, col: -1)
    @Published public var selectedCityCreator: Settler?
    @Published public var turns: [Turn] = [
        Turn(id: 1, year: -4000, ordinal: 1, displayText: "4000 BC"),
        Turn(id: 2, year: -3990, ordinal: 2, displayText: "3990 BC"),
        Turn(id: 3, year: -3980, ordinal: 3, displayText: "3980 BC"),
        Turn(id: 4, year: -3870, ordinal: 4, displayText: "3970 BC"),
        Turn(id: 5, year: -3960, ordinal: 5, displayText: "3960 BC"),
        Turn(id: 6, year: -3950, ordinal: 6, displayText: "3950 BC"),
        Turn(id: 7, year: -3940, ordinal: 7, displayText: "3940 BC"),
        Turn(id: 8, year: -3930, ordinal: 8, displayText: "3930 BC"),
        Turn(id: 9, year: -3920, ordinal: 9, displayText: "3920 BC"),
        Turn(id: 10, year: -3910, ordinal: 10, displayText: "3910 BC"),
        Turn(id: 11, year: -3900, ordinal: 11, displayText: "3900 BC"),
        Turn(id: 12, year: -3890, ordinal: 12, displayText: "3890 BC"),
        Turn(id: 13, year: -3880, ordinal: 13, displayText: "3880 BC"),
        Turn(id: 14, year: -3870, ordinal: 14, displayText: "3870 BC"),
        Turn(id: 15, year: -3860, ordinal: 15, displayText: "3860 BC"),
        Turn(id: 16, year: -3850, ordinal: 16, displayText: "3850 BC"),
        Turn(id: 17, year: -3840, ordinal: 17, displayText: "3840 BC"),
        Turn(id: 18, year: -3830, ordinal: 18, displayText: "3830 BC")

    ]
    
    @Published public var turnIndex = 0
    
    public var players: [Player] = []
    public let map: Map
    public let theme: Theme
    public var commands: [Command] = []
    public let db: Db
    public var canvasSize = CGSize.zero
    
    public init(theme: Theme, map: Map, db: Db) {
        self.theme = theme
        self.map = map
        self.db = db
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
    
    public func getCurrentPlayer() -> Player {
        return players[0]
    }
    
    public func getCurrentTurn() -> Turn {
        return turns[turnIndex]
    }
    
    public func processCommands() {
        while !commands.isEmpty {
            commands.removeLast().execute()
        }
    }
    
    public func select(mapPosition: Position) {
        self.selectedMapPosition = mapPosition
    }
}
