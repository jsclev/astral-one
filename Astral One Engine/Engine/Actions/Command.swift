import Foundation

public class Command: CustomStringConvertible {
    public internal(set) var commandId: Int
    public let player: Player
    public let type: CommandType
    public let turn: Turn
    public let ordinal: Int
    public let cost: Int
    
    init(player: Player,
         type: CommandType,
         turn: Turn,
         ordinal: Int,
         cost: Int) {
        self.commandId = Constants.noId
        self.player = player
        self.type = type
        self.turn = turn
        self.ordinal = ordinal
        self.cost = cost
    }
    
    init(commandId: Int,
         player: Player,
         type: CommandType,
         turn: Turn,
         ordinal: Int,
         cost: Int) {
        self.commandId = commandId
        self.player = player
        self.type = type
        self.turn = turn
        self.ordinal = ordinal
        self.cost = cost
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var description: String {
        return "{id: \(commandId), game: \(player.game), turn: \(turn), " +
        "player: \(player), type: \(type), ordinal: \(ordinal)}"
    }
    
    public func execute() {
        fatalError("execute() must be implemented in subclasses.")
    }
}