import Foundation
import Combine

public class Player: ObservableObject, Equatable, CustomStringConvertible, Hashable {
    public let playerId: Int
    public let type: PlayerType
    public let civilization: Civilization
    public let ordinal: Int
    public let name: String
    public let map: Map
    public let skillLevel: SkillLevel
    public let difficultyLevel: DifficultyLevel
    public let strategy: AIStrategy
    public let hud = HUDConfig()
    @Published public var cityCreators: [Builder] = []
    @Published public var units: [Unit] = []
    public var advances: [Advance] = []
    public var availableResearchActions: Set<Action> = []
    private var availableCommands: [Command] = []
    private var availableCityActions: [Action] = []
    private var researchedAdvances: Set<String> = []
    private let techTree = TechTree()
    public var maxActionPlanLength = 4
    @Published public var government = Government.Despotism
    @Published public private (set) var selectedUnit: Unit?
    @Published public private (set) var notificationMsg: String?
    private var cancellable = Set<AnyCancellable>()
    @Published public var agentMap: [[Utility]]
    @Published public private (set) var turnStatus = 0
    @Published public var otherCityCreators: [Builder] = []
    private var cityNameIndex = 0
    
    public init(playerId: Int,
                type: PlayerType,
                civilization: Civilization,
                name: String,
                ordinal: Int,
                map: Map,
                skillLevel: SkillLevel,
                difficultyLevel: DifficultyLevel,
                strategy: AIStrategy) {
        self.playerId = playerId
        self.type = type
        self.civilization = civilization
        self.ordinal = ordinal
        self.name = name
        self.map = map
        self.skillLevel = skillLevel
        self.difficultyLevel = difficultyLevel
        self.strategy = strategy
        
        self.agentMap = (0..<map.width).map { _ in (0..<map.height).map { _ in Utility() } }
        
        //        game.map.$cities
        //            .sink(receiveValue: { cities in
        //                if let city = cities.last {
        //                    if city.owner == self {
        //                        print("I own \(city.name)")
        //                    }
        //                    else {
        //                        print("I do not own \(city.name)")
        //                    }
        //
        //                    if map.isFullyVisible(position: city.position) {
        //                        print("I can see \(city.name)")
        //                    }
        //                    else {
        //                        print("I can not see \(city.name)")
        //                    }
        //
        //                    if city.owner != self && map.isFullyVisible(position: city.position) {
        //                        map.add(city: city)
        //                        print("Added \"\(city.name)\" to my map. Owned by \(city.owner.playerId).")
        //                    }
        //                }
        //            })
        //            .store(in: &cancellable)
    }
    
    public var description: String {
        return "{playerId: \(playerId), name: \(name), ordinal: \(ordinal)}"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(playerId)
    }
    
    public func setNotification(notification: String) {
        notificationMsg = notification
    }
    
    public func endTurn() {
        turnStatus = 1
    }
    
    public func startTurn() {
        turnStatus = 0
    }
    
    public func clearNotification() {
        notificationMsg = ""
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
    
    public var nextCityName: String {
        var nextName = "City"
        
        if cityNameIndex < civilization.cityNames.count {
            print("Getting city name: \(cityNameIndex): \(civilization.cityNames[cityNameIndex])")
            nextName = civilization.cityNames[cityNameIndex]
            cityNameIndex += 1
        }
        
        
        return nextName
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
    
    internal func create(city: City, using: Builder) {
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
    
    internal func add(cityCreator: Builder) {
        cityCreators.append(cityCreator)
    }
    
    internal func addOther(cityCreator: Builder) {
        otherCityCreators.append(cityCreator)
    }
    
    internal func add(unit: Unit) {
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
    
    public func set(selectedUnit: Unit) {
        self.selectedUnit = selectedUnit
    }
    
    public func deselectUnit() {
        selectedUnit = nil
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
        //        let tile = game.map.tile(at: at)
        //        tile.set(visibility: Visibility.FullyRevealed)
        //
        //        map.add(tile: tile)
    }
    
    public func clone() -> Player {
        // FIXME: Need to clone the map, right now only the pointer is being cloned
        let copy = Player(playerId: playerId,
                          type: type,
                          civilization: civilization,
                          name: name,
                          ordinal: ordinal,
                          map: map,
                          skillLevel: skillLevel,
                          difficultyLevel: difficultyLevel,
                          strategy: strategy)
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
    
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.playerId == rhs.playerId
    }
    
}
