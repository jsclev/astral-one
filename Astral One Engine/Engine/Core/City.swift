import Foundation
import Combine

public class City: ObservableObject, Equatable {
    // TODO: When a player gets the railroad advance, city tiles are
    //       automatically upgraded to have railroads, which means they
    //       now have a zero movement cost.
    public let id: Int
    public let theme: Theme
    public let owner: Player
    public var agent: CityAgent?
    public let name: String
    public let assetName: String
    public let position: Position
    public var cityRadius: [Tile] = []
    public var population: Int = 0
    private var availableActions: Set<Action> = []
    private var colossus: Colossus?
    private var greatWall: GreatWall?
    private var hangingGardens: HangingGardens?
    private var palace: Palace?
    private var pyramids: Pyramids?
    public var settlers: [Settler] = []
    private var buildings: [BuildingType: Bool]
    
    @Published var production: Int = 0
    @Published var food: Int = 0
    
    public convenience init(id: Int,
                            owner: Player,
                            theme: Theme,
                            assetName: String,
                            position: Position) {
        self.init(id: id,
                  owner: owner,
                  name: owner.nextCityName,
                  theme: theme,
                  assetName: assetName,
                  position: position)
    }
    
    public init(id: Int,
                owner: Player,
                name: String,
                theme: Theme,
                assetName: String,
                position: Position) {
        self.id = id
        self.owner = owner
        self.theme = theme
        self.assetName = theme.name + "/Cities/" + assetName
        self.position = position
        self.name = name
        
        var startRow = position.row - 2
        if startRow < 0 {
            startRow = 0
        }
        
        var endRow = position.row + 2
        if endRow > owner.map.height {
            endRow = owner.map.height - 1
        }
        
        var startCol = position.col - 2
        if startCol < 0 {
            startCol = 0
        }
        
        var endCol = position.col + 2
        if endCol > owner.map.width {
            endCol = owner.map.width - 1
        }
        
        buildings = [
            BuildingType.Airport: false,
            BuildingType.Aqueduct: false,
            BuildingType.Bank: false,
            BuildingType.Barracks: false,
            BuildingType.Capitalization: false,
            BuildingType.Cathedral: false,
            BuildingType.CityWalls: false,
            BuildingType.CoastalFortress: false,
            BuildingType.Colosseum: false,
            BuildingType.Courthouse: false,
            BuildingType.Factory: false,
            BuildingType.Granary: false,
            BuildingType.Harbor: false,
            BuildingType.HydroPlant: false,
            BuildingType.Library: false,
            BuildingType.Lighthouse: false,
            BuildingType.ManufacturingPlant: false,
            BuildingType.Marketplace: false,
            BuildingType.MassTransit: false,
            BuildingType.NuclearPlant: false,
            BuildingType.OffshorePlatform: false,
            BuildingType.Palace: false,
            BuildingType.PoliceStation: false,
            BuildingType.PortFacility: false,
            BuildingType.PowerPlant: false,
            BuildingType.RecyclingCenter: false,
            BuildingType.ResearchLab: false,
            BuildingType.SAMMissileBattery: false,
            BuildingType.SDIDefense: false,
            BuildingType.SSComponent: false,
            BuildingType.SSModule: false,
            BuildingType.SSStructural: false,
            BuildingType.SewerSystem: false,
            BuildingType.SolarPlant: false,
            BuildingType.StockExchange: false,
            BuildingType.Superhighways: false,
            BuildingType.Supermarket: false,
            BuildingType.Temple: false,
            BuildingType.University: false
        ]
        
        for row in startRow..<endRow {
            for col in startCol..<endCol {
                let tile = owner.map.tile(at: Position(row: row, col: col))
                cityRadius.append(tile)
                production += tile.production
            }
        }
        
    }
    
    public var isCoastal: Bool {
        // FIXME: Need to actually implement this
        return position.row % 2 == 0
    }
    
    public var trade: Int {
        var sum = 0
        
        if has(wonder: WonderType.Colossus) {
            // The Colossus adds +1 trade for each tile in the city radius
            sum += cityRadius.count
        }
        
        for tile in cityRadius {
            sum += tile.trade
        }
        
        return sum
    }
    
    public var taxPerTurn: Int {
        return 90
    }
    
    public var science: Int {
        var num = 0.0
        
        if has(building: BuildingType.Library) {
            num *= 1.5
        }
        
        return Int(num)
    }
    
    public var taxRate: Int {
        return 10
    }
    
    public var scienceRate: Int {
        return 90
    }
    
    public var maxTaxRate: Int {
        return 100
    }
    
    public func getDiplomacyStatus(unit: Unit) -> DiplomacyStatus {
        if owner.playerId == unit.player.playerId {
            return DiplomacyStatus.Same
        }
        
        return DiplomacyStatus.AtWar
    }
    
    public func getProductionPerTurn() -> Int {
        var sum = 1
        
        for tile in cityRadius {
            sum += tile.production
        }
        
        if has(building: BuildingType.Barracks) {
            sum += 1
        }
        
        if has(building: BuildingType.Harbor) {
            sum += 1
        }
        
        if has(building: BuildingType.Palace) {
            sum += 1
        }
        
        if has(building: BuildingType.Temple) {
            sum += 1
        }
        
        if has(wonder: WonderType.Colossus) {
            sum += 2
        }
        
        if has(wonder: WonderType.HangingGardens) {
            sum += 1
        }
        
        if has(wonder: WonderType.Pyramids) {
            sum += 1
        }
        
        return sum
    }
    
    public func getDistance(to: Unit) -> Int {
        return abs(position.row - to.position.row) + abs(position.col - to.position.col) - 1
    }
    
    public func build(_ building: BuildingType) {
        buildings[building] = true
    }
    
    public func build(_ wonder: WonderType) {
        switch wonder {
        case .AdamSmithsTradingCo:
            fatalError("Cannot build this wonder in a city.")
        case .ApolloProgram:
            fatalError("Cannot build this wonder in a city.")
        case .Colossus:
            colossus = Colossus(imageName: "colossus-1")
        case .CopernicusObservatory:
            fatalError("Cannot build this wonder in a city.")
        case .CureForCancer:
            fatalError("Cannot build this wonder in a city.")
        case .DarwinsVoyage:
            fatalError("Cannot build this wonder in a city.")
        case .EiffelTower:
            fatalError("Cannot build this wonder in a city.")
        case .GreatLibrary:
            fatalError("Cannot build this wonder in a city.")
        case .GreatWall:
            greatWall = GreatWall(imageName: "great-wall-1")
        case .HangingGardens:
            hangingGardens = HangingGardens(imageName: "hanging-gardens-1")
        case .HooverDam:
            fatalError("Cannot build this wonder in a city.")
        case .IsaacNewtonsCollege:
            fatalError("Cannot build this wonder in a city.")
        case .JSBachsCathedral:
            fatalError("Cannot build this wonder in a city.")
        case .KingRichardsCrusade:
            fatalError("Cannot build this wonder in a city.")
        case .LeonardosWorkshop:
            fatalError("Cannot build this wonder in a city.")
        case .Lighthouse:
            fatalError("Cannot build this wonder in a city.")
        case .MagellansExpedition:
            fatalError("Cannot build this wonder in a city.")
        case .ManhattenProject:
            fatalError("Cannot build this wonder in a city.")
        case .MarcoPolosEmbassy:
            fatalError("Cannot build this wonder in a city.")
        case .MichelangelosChapel:
            fatalError("Cannot build this wonder in a city.")
        case .Oracle:
            fatalError("Cannot build this wonder in a city.")
        case .Pyramids:
            pyramids = Pyramids(imageName: "pyramids-1")
        case .SETIProgram:
            fatalError("Cannot build this wonder in a city.")
        case .ShakespearesTheatre:
            fatalError("Cannot build this wonder in a city.")
        case .StatueOfLiberty:
            fatalError("Cannot build this wonder in a city.")
        case .SunTzusWarAcademy:
            fatalError("Cannot build this wonder in a city.")
        case .UnitedNations:
            fatalError("Cannot build this wonder in a city.")
        case .WomensSuffrage:
            fatalError("Cannot build this wonder in a city.")
        }
    }
    
    public func create(settler: Settler) {
        settlers.append(settler)
    }
    
    public func build(improvement: ImprovementType, position: Position) {
        print("Building \(improvement) at position \(position).")
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
    
    public func addPopulation(amount: Int) {
        population += amount
    }
    
    public func clone() -> City {
        let copy = City(id: id,
                        owner: owner,
                        name: name,
                        theme: theme,
                        assetName: assetName,
                        position: position)
        copy.buildings = buildings
        
        if has(wonder: WonderType.HangingGardens) {
            copy.build(WonderType.HangingGardens)
        }
        
        for action in availableActions {
            copy.addAvailable(action: action.clone())
        }
        
        return copy
    }
    
    public static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func canBuild(building: BuildingType) -> Bool {
        if building == BuildingType.Harbor {
            return isCoastal && !has(building: BuildingType.Harbor)
        }
        
        return !has(building: building)
    }
    
    public func has(building: BuildingType) -> Bool {
        return buildings[building]!
    }
    
    public func has(wonder: WonderType) -> Bool {
        switch wonder {
        case WonderType.Colossus:
            return colossus != nil
        case WonderType.GreatWall:
            return greatWall != nil
        case WonderType.HangingGardens:
            return hangingGardens != nil
        case WonderType.Pyramids:
            return pyramids != nil
        default:
            return false
        }
    }
    
}
