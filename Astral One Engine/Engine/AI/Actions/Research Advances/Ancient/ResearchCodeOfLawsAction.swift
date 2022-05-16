import Foundation

public class ResearchCodeOfLawsAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Code of Laws")
        
        preconditions = []
        effects = []
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {

    }
    
    public override func clone() -> Action {
        let copy = ResearchCodeOfLawsAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
