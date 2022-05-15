import Foundation

public class ResearchAction: Action {
    public override init(id: Int, name: String) {
        super.init(id: id, name: name)
    }
    
    public override func execute(game: Game, player: Player) {
        fatalError("Need to implement in subclass")
    }
    
    public func clone2() -> ResearchAction {
        fatalError("Need to implement in subclass")
    }
    
    public func copyProps(source: ResearchAction, target: ResearchAction) {
        target.cost = source.cost
        target.scienceCost = source.scienceCost
        target.numTurns = source.numTurns
        
        target.preconditions = source.preconditions
        target.effects = source.effects
    }
    
}
