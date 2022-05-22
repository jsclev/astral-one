import Foundation
import Combine



public class Player: ObservableObject {
    public let playerId: Int
    public let game: Game
    public let skillLevel: SkillLevel
    public let difficultyLevel: DifficultyLevel
    public let playStyle: PlayStyle
    @Published public var cities: [City] = []
    public var cityBuilders: [CityBuilder] = []
    @Published public var units: [Unit] = []
    public var advances: [Advance] = []
    private var availableResearchActions: Set<Action> = []
    private var availableCommands: [Command] = []
    private var availableCityActions: [Action] = []
    private var researchedAdvances: Set<String> = []
    private let techTree = TechTree()
    public var maxActionPlanLength = 4
    
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
    
    public init(playerId: Int, game: Game) {
        self.playerId = playerId
        self.game = game
        self.skillLevel = SkillLevel.Prince
        self.difficultyLevel = DifficultyLevel.Normal
        self.playStyle = PlayStyle(offense: 0.15, defense: 0.35)
    }
    
    public init(playerId: Int,
                game: Game,
                skillLevel: SkillLevel,
                difficultyLevel: DifficultyLevel,
                playStyle: PlayStyle) {
        self.playerId = playerId
        self.game = game
        self.skillLevel = skillLevel
        self.difficultyLevel = difficultyLevel
        self.playStyle = playStyle
    }
    
//    public func research(advance)
    
    public func getCity(at: Position) -> City? {
        for city in cities {
            if city.position == at {
                return city
            }
        }
        
        return nil
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
    
    public func build(city: City, using: CityBuilder) {
        cities.append(city)
        
        for action in availableCityActions {
            city.addAvailable(action: action)
        }
        
        // City builders are consumed when the city is built
        if let index = cityBuilders.lastIndex(of: using) {
            cityBuilders.remove(at: index)
        }
        
        if let index = units.lastIndex(of: using) {
            units.remove(at: index)
        }
        
        // City builders become the first population point of new cities
        if let index = cities.lastIndex(of: city) {
            cities[index].addPopulation(amount: 1)
        }
    }
    
    public func add(city: City) {
        cities.append(city)
    }
    
    public func addAvailable(cityAction: Action) {
        availableCityActions.append(cityAction)
    }
    
    public func add(cityBuilder: CityBuilder) {
        cityBuilders.append(cityBuilder)
        
        
        
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
        
//        do {
//            try game.map.add(unit: unit)
//        }
//        catch {
//            fatalError("\(error)")
//        }
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
    
    public func clone() -> Player {
        let copy = Player(playerId: playerId,
                          game: game,
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
        
        for city in cities {
            copy.cities.append(city.clone())
        }
        
        for action in availableResearchActions {
            copy.addAvailable(researchAction: action.clone() as! ResearchAction)
        }
        
        return copy
    }
    
    public func canBuild(buildingType: BuildingType) -> Bool {
        for city in cities {
            if city.has(building: buildingType) {
                return false
            }
        }
            
        return true
    }
    
    public func canBuild(wonder: WonderType) -> Bool {
        for city in cities {
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
