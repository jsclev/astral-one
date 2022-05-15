import Foundation
import Combine

public struct PlayerDiff {
    public let defense: Double
    
    public init(defense: Double) {
        self.defense = defense
    }
}

public class Player: ObservableObject {
    public let playerId: Int
    public let game: Game
    public let skillLevel: SkillLevel
    public let playStyle: PlayStyle
    @Published public var cities: [City] = []
    public var cityCreators: [CityCreator] = []
    @Published public var units: [Unit] = []
    public var advances: [Advance] = []
    private var availableResearchActions: Set<Action> = []
    private var researchedAdvances: Set<String> = []
    
    public var defense: Double {
        var sum = 0.0
        
        for unit in units {
            sum += unit.defense
        }
        
        if sum < 0.01 {
            return 0.001
        }
        else {
            return sum
        }
    }
    
    public var defenseAgainstGroundAttacks: Double {
        var sum = 0.0
        
        for unit in units {
            sum += unit.defenseAgainstGroundAttacks
        }
        
        if sum < 0.01 {
            return 0.001
        }
        else {
            return sum
        }
    }
    
    public init(playerId: Int, game: Game) {
        self.playerId = playerId
        self.game = game
        self.skillLevel = SkillLevel.Prince
        self.playStyle = PlayStyle(offense: 0.15, defense: 0.35)
    }
    
    public init(playerId: Int,
                game: Game,
                skillLevel: SkillLevel,
                playStyle: PlayStyle) {
        self.playerId = playerId
        self.game = game
        self.skillLevel = skillLevel
        self.playStyle = playStyle
    }
    
    public func add(city: City) {
        cities.append(city)
    }
    
    public func add(cityCreator: CityCreator) {
        cityCreators.append(cityCreator)
    }
    
    public func add(unit: Unit) {
        units.append(unit)
        
//        do {
//            try game.map.add(unit: unit)
//        }
//        catch {
//            fatalError("\(error)")
//        }
    }
    
    public func add(advanceName: String) {
        researchedAdvances.insert(advanceName)
    }
    
    public func getAvailableActions() -> Set<Action> {
        var availableActions: Set<Action> = []
        for action in availableResearchActions {
            availableActions.insert(action)
        }
        
        return availableActions
    }
    
    public func addAvailable(researchAction: ResearchAction) {
        availableResearchActions.insert(researchAction)
    }
    
    public func removeAvailable(researchAction: ResearchAction) {
        availableResearchActions.remove(researchAction)
    }
    
    public func getRandomAvailableAction() -> Action? {
        var availableActions: Set<Action> = []
        
        for city in cities {
            availableActions = availableActions.union(city.getAvailableActions())
        }
        
        availableActions = availableActions.union(availableResearchActions)
        
        if let action = availableActions.randomElement() {
            return action
        }
        
        return nil
    }
    
    public func updateAvailableActions() {
        
    }
    
    public func hasResearched(advanceName: String) -> Bool {
        return researchedAdvances.contains(advanceName)
    }
    
    public func diff(other: Player) -> PlayerDiff {
        return PlayerDiff(defense: defense - other.defense)
    }
    
    public func clone() -> Player {
        let copy = Player(playerId: playerId,
                          game: game,
                          skillLevel: skillLevel,
                          playStyle: playStyle)
        
        for unit in units {
            copy.add(unit: unit)
        }
        
        for city in cities {
            copy.add(city: city.clone())
        }
        
        for action in availableResearchActions {
            copy.addAvailable(researchAction: action.clone() as! ResearchAction)
        }
        
        return copy
    }
    
}
