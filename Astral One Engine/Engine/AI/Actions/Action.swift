import Foundation

public class Action {
    var preconditions: Set<String> = []
    var effects: Set<String> = []
    
    var cost: Int = 0
    var scienceCost: Int = 0
    var numTurns: Int = 0
    
    public init() {
        
    }
    
    public func execute(game: Game, player: Player) {
        fatalError("Need to implement in subclass")
    }
    
    public func clone() -> Action {
        fatalError("Need to implement in subclass")
    }
    
}
