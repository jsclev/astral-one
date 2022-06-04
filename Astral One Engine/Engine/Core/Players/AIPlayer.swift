import Foundation

public class AIPlayer: Player {
    public let playStyle: PlayStyle
    public let skillLevel: SkillLevel
    public let difficultyLevel: DifficultyLevel
    
    public init(playerId: Int,
                game: Game,
                map: Map,
                skillLevel: SkillLevel,
                difficultyLevel: DifficultyLevel,
                playStyle: PlayStyle) {
        self.skillLevel = skillLevel
        self.difficultyLevel = difficultyLevel
        self.playStyle = playStyle
        
        super.init(playerId: playerId, game: game, map: map)
    }
    
    public override func clone() -> Player {
        let copy = AIPlayer(playerId: playerId,
                            game: game,
                            map: map,
                            skillLevel: skillLevel,
                            difficultyLevel: difficultyLevel,
                            playStyle: playStyle)
        //        copy.cities = []
        //        copy.units = []
        //        copy.availableCommands = []
        //        copy.cityBuilders = []
        //        copy.availableResearchActions = []
        
        for unit in units {
            copy.units.append(unit.clone())
        }
        
        //        for city in cities {
        //            copy.cities.append(city.clone())
        //        }
        
        for action in availableResearchActions {
            copy.addAvailable(researchAction: action.clone() as! ResearchAction)
        }
        
        return copy
    }
}
