import Foundation

public class ResearchMasonryAction: ResearchAction {
    
    public init() {
        super.init(id: 2, name: "Research Masonry")

        preconditions = [
            "has_barracks"
        ]
        
        effects = [
            "advance_unlocked_masonry"
        ]
    }
    
    public override func execute(game: Game, player: Player) {
        for city in player.cities {
            city.addAvailable(action: BuildWallsAction(city: city))
        }
        
        player.removeAvailable(researchAction: self)
    }
    
    public override func clone() -> Action {
        let copy = ResearchMasonryAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
