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
        
        scienceCost = 5
    }
    
    public override func execute(game: Game, player: Player) {
        for city in player.cities {
            city.addAvailable(action: BuildCityWallsAction(city: city))
            city.addAvailable(action: BuildPalaceAction(city: city))
            city.addAvailable(action: BuildPyramidsAction(city: city))
            city.addAvailable(action: BuildGreatWallAction(city: city))
        }
        
        player.removeAvailable(researchAction: self)
    }
    
    public override func clone() -> Action {
        let copy = ResearchMasonryAction()
        copyProps(source: self, target: copy)
        
        return copy
    }
}
