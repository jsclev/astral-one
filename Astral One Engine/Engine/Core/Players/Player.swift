import Foundation
import Combine



public class Player: ObservableObject {
    public let playerId: Int
    public let game: Game
    public let map: Map
    @Published public var cityCreators: [CityCreator] = []
    @Published public var units: [Unit] = []
    public var advances: [Advance] = []
    public var availableResearchActions: Set<Action> = []
    private var availableCommands: [Command] = []
    private var availableCityActions: [Action] = []
    private var researchedAdvances: Set<String> = []
    private let techTree = TechTree()
    public var maxActionPlanLength = 4
    @Published public var government = Government.Despotism
    
    public init(playerId: Int, game: Game, map: Map) {
        self.playerId = playerId
        self.game = game
        self.map = map
    }
    
    public var settlers: [Settler] {
        var ret: [Settler] = []
        
        for city in map.cities {
            for settler in city.settlers {
                ret.append(settler)
            }
        }
        
        return ret
    }
    
    public var population: Int {
        var sum = 0
        
        for city in map.cities {
            sum += city.population
        }
        
        return sum
    }
    
    public var defense: Double {
        var sum = 0.0
        
        for unit in units {
            sum += unit.defense
        }
        
        if sum < 0.0001 {
            return 0.0001
        }
        else {
            return sum
        }
    }
    
    public var score: Int {
        var sum = 0
        
        for city in map.cities {
            sum += city.science
        }
        
        return sum
    }
    
    public func get(advanceType: AdvanceType) -> Advance {
        if let advance = techTree.advances[advanceType] {
            return advance
        }
        
        return Advance(type: AdvanceType.Error, parents: [])
    }
    
//    public func getActions() -> [[Action]] {
//        for action in availableResearchActions {
//            var plan: [Action] = []
//
//            action.execute()
//            plan.append(action)
//
//            while plan.count <= maxActionPlanLength {
//
//            }
//
//        }
//    }
    
    public func startResearching(advanceType: AdvanceType) {
        if let advance = techTree.advances[advanceType] {
            advance.isResearching = true
        }
    }
    
    public func completeResearch(advanceType: AdvanceType) {
        if let advance = techTree.advances[advanceType] {
            advance.isResearching = false
            advance.completed = true
        }
    }
    
    public func defense(against: Unit) -> Double {
        var sum = 0.0
        
        for unit in units {
            sum += unit.defense(against: against)
        }
        
        if sum < 0.0001 {
            return 0.0001
        }
        else {
            return sum
        }
    }
    
    public var attack: Double {
        var sum = 0.0
        
        for unit in units {
            sum += unit.attack
        }
        
        if sum < 0.01 {
            return 0.001
        }
        else {
            return sum
        }
    }
    
    public var sciencePerTurn: Double {
        if units.count > 0 {
            return Double(units.count) * 10.0
        }
        
        return 1.0
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
    
    public func getCity(at: Position) -> City? {
        return map.tile(at: at).city
    }
    
    public func diff(other: Player) -> PlayerDiff {
        let attack = other.attack - attack
        let defense = other.defense - defense
        let defAgainstGroundAttacks = other.defenseAgainstGroundAttacks - defenseAgainstGroundAttacks
        
        let diff = PlayerDiff(attack: attack,
                              defense: defense,
                              defenseAgainstGroundAttacks: defAgainstGroundAttacks)
        
        return diff
    }
    
    internal func build(city: City, using: CityCreator) {
        map.add(city: city)
        
//        for action in availableCityActions {
//            city.addAvailable(action: action)
//        }

        // City builders are consumed when the city is built
        if let index = cityCreators.lastIndex(of: using) {
            cityCreators.remove(at: index)
        }

//        if let index = units.lastIndex(of: using) {
//            units.remove(at: index)
//        }

        // City builders become the first population point of new cities
        city.addPopulation(amount: 1)
    }
    
    public func addAvailable(cityAction: Action) {
        availableCityActions.append(cityAction)
    }
    
    public func add(cityCreator: CityCreator) {
        cityCreators.append(cityCreator)
//        availableCommands.append(BuildCityCommand(commandId: <#T##Int#>,
//                                                  game: <#T##Game#>,
//                                                  turn: <#T##Turn#>,
//                                                  player: <#T##Player#>,
//                                                  type: <#T##CommandType#>,
//                                                  ordinal: 1,
//                                                  cityBuilder: cityBuilder))
    }
    
    public func add(unit: Unit) {
        units.append(unit)
    }
    
    public func remove(unit: Unit) {
        if let index = units.firstIndex(where: {$0.name == unit.name}) {
            units.remove(at: index)
        }
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
    
    public func getAvailableCityActions() -> [Action] {
        return availableCityActions
    }
    
    public func getAvailableCommands() -> [Command] {
        return Array(availableCommands)
    }
    
    public func addAvailable(researchAction: ResearchAction) {
        availableResearchActions.insert(researchAction)
    }
    
    public func addAvailable(command: Command) {
        availableCommands.append(command)
    }
    
    public func removeAvailable(researchAction: ResearchAction) {
        availableResearchActions.remove(researchAction)
    }
    
    public func getRandomAvailableAction() -> Action? {
        var availableActions: Set<Action> = []
        
        for city in map.cities {
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
    
    public func revealTile(at: Position) {
        let tile = game.map.tile(at: at)
        tile.set(visibility: Visibility.FullyRevealed)
        
        map.add(tile: tile)
    }
    
    public func getTilesWithinCityRadius(from: Position) -> [Tile] {
        var cityRadiusTiles: [Tile] = []
        var positions: [Position] = []
        
        let startRow = from.row - 2
        let endRow = from.row + 2
        let startCol = from.col - 2
        let endCol = from.col + 2
        
        for row in startRow...endRow {
            for col in startCol...endCol {
                // We don't add the outer corners in the city radius
                if row == startRow && col == startCol ||
                    row == endRow && col == startCol ||
                    row == startRow && col == endCol ||
                    row == endRow && col == endCol {
                    continue
                }
                else {
                    positions.append(Position(row: row, col: col))
                }
            }
        }
        
        positions = positions.filter{
            $0.row >= 0 &&
            $0.row < map.height &&
            $0.col >= 0 &&
            $0.col < map.width
        }
        
        for position in positions {
            cityRadiusTiles.append(map.tile(at: position))
        }
        
        return cityRadiusTiles
    }
    
    public func clone() -> Player {
        let copy = Player(playerId: playerId,
                          game: game,
                          map: map)
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
    
    public func canBuild(buildingType: BuildingType) -> Bool {
        for city in map.cities {
            if city.has(building: buildingType) {
                return false
            }
        }
            
        return true
    }
    
    public func canBuild(wonder: WonderType) -> Bool {
        for city in map.cities {
            if city.has(wonder: wonder) {
                return false
            }
        }
        
        return true
    }
    
    public func has(buildingType: BuildingType, in: City) -> Bool {
//        switch buildingType {
//        case BuildingType.Barracks:
//            return barracks != nil
//        case BuildingType.CityWalls:
//            return walls != nil
//        case BuildingType.Granary:
//            return granary != nil
//        case BuildingType.Harbor:
//            return harbor != nil
//        default:
//            return false
//        }
        return false
    }
    
}
