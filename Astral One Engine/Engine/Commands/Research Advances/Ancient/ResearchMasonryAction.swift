import Foundation

public class ResearchMasonryAction: ResearchAction {
    
    public init(game: Game, player: Player) {
        super.init(id: 2, name: "Research Masonry", game: game, player: player)

        preconditions = [
            "has_barracks"
        ]
        
        effects = [
            "advance_unlocked_masonry"
        ]
        
        scienceCost = 25
    }
    
    public override func execute() {
        player.removeAvailable(researchAction: self)

        for city in player.map.cities {
            city.addAvailable(action: BuildCityWallsAction(game: game, player: player, city: city))
            city.addAvailable(action: BuildPalaceAction(game: game, player: player, city: city))
            city.addAvailable(action: BuildPyramidsAction(game: game, player: player, city: city))
            city.addAvailable(action: BuildGreatWallAction(game: game, player: player, city: city))
        }
    }
    
    public override func clone() -> Action {
        let copy = ResearchMasonryAction(game: game, player: player)
        copyProps(source: self, target: copy)
        
        return copy
    }
}
