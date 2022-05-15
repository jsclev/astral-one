import Foundation

public class ResearchCurrencyAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Currency")
        
        preconditions = []
        effects = []
        cost = 20
        scienceCost = 0
    }
    
    public override func execute(game: Game, player: Player) {
        
    }
    
    public override func clone() -> Action {
        let copy = ResearchCurrencyAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
