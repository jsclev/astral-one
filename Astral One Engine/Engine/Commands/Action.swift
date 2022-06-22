import Foundation

public class Action: Hashable {
    public let id: Int
    public let name: String
    public let game: Game
    public let player: Player
    var preconditions: Set<String> = []
    var effects: Set<String> = []
    
    public var cost: Int = 0
    var scienceCost: Int = 0
    
    public var numTurns: Double {
        fatalError("Need to implement in subclass")
    }
    
    public init(id: Int, name: String, game: Game, player: Player) {
        self.id = id
        self.name = name
        self.game = game
        self.player = player
    }
    
    public func execute() {
        fatalError("Need to implement in subclass")
    }
    
    public func clone() -> Action {
        fatalError("Need to implement in subclass")
    }
    
    public func copyProps(source: Action, target: Action) {
        target.cost = source.cost
        target.scienceCost = source.scienceCost
        
        target.preconditions = source.preconditions
        target.effects = source.effects
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    public static func == (lhs: Action, rhs: Action) -> Bool {
        return lhs.name == rhs.name
    }
    
}
