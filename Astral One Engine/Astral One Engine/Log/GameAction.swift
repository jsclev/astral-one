import GameplayKit

public class Action: CustomStringConvertible {
    public let id: Int
    public let gameId: Int
    public let turn: Turn
    public let gamePlayerId: Int
    public let actionType: ActionType
    public let ordinal: Int
    
    public var description: String {
        return "{id: \(id), game: \(gameId), turn: \(turn), " +
               "playerId: \(gamePlayerId), actionType: \(actionType), ordinal: \(ordinal)}"
    }

    init(id: Int, gameId: Int, turn: Turn, gamePlayerId: Int, actionType: ActionType, ordinal: Int) {
        self.id = id
        self.gameId = gameId
        self.turn = turn
        self.gamePlayerId = gamePlayerId
        self.actionType = actionType
        self.ordinal = ordinal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
