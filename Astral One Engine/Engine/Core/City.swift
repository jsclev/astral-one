import Foundation
import Combine

public class City: ObservableObject, Equatable {
    public let theme: Theme
    public let player: Player
    public let name: String
    public let assetName: String
    public let position: Position
    private var availableActions: Set<Action> = []
    private var barracks: Barracks?
    private var walls: Walls?
    
    @Published var production: Int = 0
    @Published var food: Int = 0
    
    public var hasBarracks: Bool {
        return barracks != nil
    }
    
    public var hasWalls: Bool {
        return walls != nil
    }
    
    public var isCoastal: Bool {
        return position.row % 2 == 0
    }
    
    public init(player: Player,
                theme: Theme,
                name: String,
                assetName: String,
                position: Position) {
        self.player = player
        self.theme = theme
        self.name = name
        self.assetName = theme.name + "/Cities/" + assetName
        self.position = position
    }
    
    public func getDiplomacyStatus(unit: Unit) -> DiplomacyStatus {
        if player.playerId == unit.player.playerId {
            return DiplomacyStatus.Same
        }
        
        return DiplomacyStatus.AtWar
    }
    
    public func getDistance(to: Unit) -> Int {
        return abs(position.row - to.position.row) + abs(position.col - to.position.col) - 1
    }
    
    public func addBarracks() {
        barracks = Barracks(imageName: "city-1")
    }
    
    public func addWalls() {
        walls = Walls(imageName: "walls-1")
    }
    
    public func getAvailableActions() -> Set<Action> {
        return availableActions
    }
    
    public func addAvailable(action: Action) {
        availableActions.insert(action)
    }
    
    public func removeAvailable(action: Action) {
        availableActions.remove(action)
    }
    
    public func clone() -> City {
        let copy = City(player: player,
                        theme: theme,
                        name: name,
                        assetName: assetName,
                        position: position)
        
        if hasBarracks {
            copy.addBarracks()
        }
        
        for action in availableActions {
            copy.addAvailable(action: action.clone())
        }
        
        return copy
    }
    
    public static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
    
}
