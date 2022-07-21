import Foundation

public class Command: CustomStringConvertible {
    public internal(set) var commandId: Int
    internal let persist: Bool
    internal let database: Db?
    public let player: Player
    public let turn: Turn
    public let ordinal: Int
    public let cost: Double
    
    internal init(player: Player,
                  turn: Turn,
                  ordinal: Int,
                  cost: Double) {
        self.commandId = Constants.noId
        self.persist = false
        self.database = nil
        self.player = player
        self.turn = turn
        self.ordinal = ordinal
        self.cost = cost
    }
    
    internal init(commandId: Int,
                  player: Player,
                  turn: Turn,
                  ordinal: Int,
                  cost: Double) {
        self.commandId = commandId
        self.persist = false
        self.database = nil
        self.player = player
        self.turn = turn
        self.ordinal = ordinal
        self.cost = cost
    }
    
    internal init(db: Db,
                  player: Player,
                  turn: Turn,
                  ordinal: Int,
                  cost: Double) {
        self.commandId = Constants.noId
        self.persist = true
        self.database = db
        self.player = player
        self.turn = turn
        self.ordinal = ordinal
        self.cost = cost
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    public var description: String {
        return "{id: \(commandId), turn: \(turn), player: \(player), ordinal: \(ordinal)}"
    }
    
    public var displayText: String {
        fatalError("displayText property must be implemented by \(String(describing: self)) class.")
    }
    
    public var debugText: String {
        fatalError("debugText property must be implemented by \(String(describing: self)) class.")
    }
    
    public func execute() -> CommandResult {
        fatalError("execute() must be implemented by subclasses.")
    }
}
