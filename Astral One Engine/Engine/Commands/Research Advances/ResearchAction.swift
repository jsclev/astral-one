import Foundation

public class ResearchAction: Action {
    public override init(id: Int, name: String, game: Game, player: Player) {
        super.init(id: id, name: name, game: game, player: player)
    }
    
    public override var numTurns: Double {
        return Double(scienceCost) / player.sciencePerTurn
    }
    
    public override func execute() {
        fatalError("Need to implement in subclass")
    }
    
    public func clone2() -> ResearchAction {
        fatalError("Need to implement in subclass")
    }
    
    public func copyProps(source: ResearchAction, target: ResearchAction) {
        target.cost = source.cost
        target.scienceCost = source.scienceCost
        
        target.preconditions = source.preconditions
        target.effects = source.effects
    }
    
}
