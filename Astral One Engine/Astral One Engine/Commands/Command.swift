import Foundation

public class Command: CustomStringConvertible {
    public let id: Int
    public let gameId: Int
    public let turn: Turn
    public let playerId: Int
    public let type: CommandType
    public let ordinal: Int
    
    public var description: String {
        return "{id: \(id), game: \(gameId), turn: \(turn), " +
            "playerId: \(playerId), type: \(type), ordinal: \(ordinal)}"
    }
    
    init(id: Int, gameId: Int, turn: Turn, playerId: Int, type: CommandType, ordinal: Int) {
        self.id = id
        self.gameId = gameId
        self.turn = turn
        self.playerId = playerId
        self.type = type
        self.ordinal = ordinal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func execute() {
        fatalError("execute() has not been implemented")
    }
}
