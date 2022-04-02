import GameplayKit

public class GameAction {
    public let id: Int
    public let gameId: Int
    public let turnId: Int
    public let gamePlayerId: Int
    public let actionId: Int
    public let ordinal: Int

    init(id: Int, gameId: Int, turnId: Int, gamePlayerId: Int, actionId: Int, ordinal: Int) {
        self.id = id
        self.gameId = gameId
        self.turnId = turnId
        self.gamePlayerId = gamePlayerId
        self.actionId = actionId
        self.ordinal = ordinal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
