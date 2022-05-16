import Foundation

public class Command: CustomStringConvertible {
    public let commandId: Int
    public let game: Game
    public let turn: Turn
    public let player: Player
    public let type: CommandType
    public let ordinal: Int
    
    init(commandId: Int, game: Game, turn: Turn, player: Player, type: CommandType, ordinal: Int) {
        self.commandId = commandId
        self.game = game
        self.turn = turn
        self.player = player
        self.type = type
        self.ordinal = ordinal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var description: String {
        return "{id: \(commandId), game: \(game), turn: \(turn), " +
        "player: \(player), type: \(type), ordinal: \(ordinal)}"
    }
    
    public func execute() {
        fatalError("execute() has not been implemented")
    }
}
