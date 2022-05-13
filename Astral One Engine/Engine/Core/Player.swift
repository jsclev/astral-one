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
    @Published public var cities: [City] = []
    public var cityCreators: [CityCreator] = []
    public var units: [Unit] = []
    public var advances: [Advance] = []
    private var availableActions: Set<Action> = []
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
    
    public init(playerId: Int) {
        self.playerId = playerId
    }
    
    public func add(city: City) {
        cities.append(city)
    }
    
    public func add(cityCreator: CityCreator) {
        cityCreators.append(cityCreator)
    }
    
    public func add(unit: Unit) {
        units.append(unit)
    }
    
    public func add(advanceName: String) {
        researchedAdvances.insert(advanceName)
    }
    
    public func getAvailableActions() -> [Action] {
        return [Action](availableActions)
    }
    
    public func addAvailable(action: Action) {
        availableActions.insert(action)
    }
    
    public func removeAvailable(action: Action) {
        availableActions.remove(action)
    }
    
    public func getRandomAvailableAction() -> Action {
        if let action = availableActions.randomElement() {
            return action
        }
        
        return BuildBarracksAction()
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
        let copy = Player(playerId: self.playerId)
        
        for unit in units {
            copy.add(unit: unit)
        }
        
        for action in availableActions {
            copy.addAvailable(action: action.clone())
        }
        
        return copy
    }
    
}
