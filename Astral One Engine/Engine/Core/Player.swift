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
    public var availableActions: [Action] = []
    
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
    
    public func add(advance: Advance) {
        advances.append(advance)
    }
    
    public func addAvailable(action: Action) {
        availableActions.append(action)
    }
    
    public func diff(other: Player) -> PlayerDiff {
        var diff = PlayerDiff(defense: defense - other.defense)
        
        return diff
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
