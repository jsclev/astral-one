import Foundation

public class Action: Hashable {
    public let id: Int
    public let name: String
    var preconditions: Set<String> = []
    var effects: Set<String> = []
    
    var cost: Int = 0
    var scienceCost: Int = 0
    var numTurns: Int = 0
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    public func execute(game: Game, player: Player) {
        fatalError("Need to implement in subclass")
    }
    
    public func execute(game: Game, player: Player, city: City) {
        fatalError("Need to implement in subclass")
    }
    
    public func clone() -> Action {
        fatalError("Need to implement in subclass")
    }
    
    public func copyProps(source: Action, target: Action) {
        target.cost = source.cost
        target.scienceCost = source.scienceCost
        target.numTurns = source.numTurns
        
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
