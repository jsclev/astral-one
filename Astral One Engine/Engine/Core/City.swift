import Foundation
import Combine

public class City: ObservableObject, Equatable {
    // TODO: When a player gets the railroad advance, city tiles are
    //       automatically upgraded to have railroads, which means they
    //       now have a zero movement cost.
    public let id: Int
    public let theme: Theme
    public let owner: Player
    public let name: String
    public let assetName: String
    public let position: Position
    public var cityRadius: [Tile] = []
    public var population: Int = 0
    private var availableActions: Set<Action> = []
    private var barracks: Barracks?
    private var colossus: Colossus?
    private var granary: Granary?
    private var greatWall: GreatWall?
    private var hangingGardens: HangingGardens?
    private var harbor: Harbor?
    private var palace: Palace?
    private var pyramids: Pyramids?
    private var temple: Temple?
    private var cityWalls: CityWalls?
    public var settlers: [Settler] = []
    
    @Published var production: Int = 0
    @Published var food: Int = 0
    
    public var isCoastal: Bool {
        return position.row % 2 == 0
    }
    
    public init(id: Int,
                owner: Player,
                theme: Theme,
                name: String,
                assetName: String,
                position: Position) {
        self.id = id
        self.owner = owner
        self.theme = theme
        self.name = name
        self.assetName = theme.name + "/Cities/" + assetName
        self.position = position
        
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
        
        for row in startRow..<endRow {
            for col in startCol..<endCol {
                let tile = owner.map.tile(at: Position(row: row, col: col))
                cityRadius.append(tile)
                production += tile.production
            }
        }
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
        switch building {
        case .Airport:
            fatalError("Cannot build this building in a city.")
        case .Aqueduct:
            fatalError("Cannot build this building in a city.")
        case .Bank:
            fatalError("Cannot build this building in a city.")
        case .Barracks:
            barracks = Barracks(imageName: "barracks-1")
        case .Capitalization:
            fatalError("Cannot build this building in a city.")
        case .Cathedral:
            fatalError("Cannot build this building in a city.")
        case .CityWalls:
            cityWalls = CityWalls(imageName: "city-walls-1")
        case .CoastalFortress:
            fatalError("Cannot build this building in a city.")
        case .Colosseum:
            fatalError("Cannot build this building in a city.")
        case .Courthouse:
            fatalError("Cannot build this building in a city.")
        case .Factory:
            fatalError("Cannot build this building in a city.")
        case .Granary:
            granary = Granary(imageName: "granary-1")
        case .Harbor:
            harbor = Harbor(imageName: "harbor-1")
        case .HydroPlant:
            fatalError("Cannot build this building in a city.")
        case .Library:
            fatalError("Cannot build this building in a city.")
        case .ManufacturingPlant:
            fatalError("Cannot build this building in a city.")
        case .Marketplace:
            fatalError("Cannot build this building in a city.")
        case .MassTransit:
            fatalError("Cannot build this building in a city.")
        case .NuclearPlant:
            fatalError("Cannot build this building in a city.")
        case .OffshorePlatform:
            fatalError("Cannot build this building in a city.")
        case .Palace:
            palace = Palace(imageName: "palace-1")
        case .PoliceStation:
            fatalError("Cannot build this building in a city.")
        case .PortFacility:
            fatalError("Cannot build this building in a city.")
        case .PowerPlant:
            fatalError("Cannot build this building in a city.")
        case .RecyclingCenter:
            fatalError("Cannot build this building in a city.")
        case .ResearchLab:
            fatalError("Cannot build this building in a city.")
        case .SAMMissileBattery:
            fatalError("Cannot build this building in a city.")
        case .SDIDefense:
            fatalError("Cannot build this building in a city.")
        case .SSComponent:
            fatalError("Cannot build this building in a city.")
        case .SSModule:
            fatalError("Cannot build this building in a city.")
        case .SSStructural:
            fatalError("Cannot build this building in a city.")
        case .SewerSystem:
            fatalError("Cannot build this building in a city.")
        case .SolarPlant:
            fatalError("Cannot build this building in a city.")
        case .StockExchange:
            fatalError("Cannot build this building in a city.")
        case .Superhighways:
            fatalError("Cannot build this building in a city.")
        case .Supermarket:
            fatalError("Cannot build this building in a city.")
        case .Temple:
            temple = Temple(imageName: "temple-1")
        case .University:
            fatalError("Cannot build this building in a city.")
        }
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
                        theme: theme,
                        name: name,
                        assetName: assetName,
                        position: position)
        
        if has(building: BuildingType.Barracks) {
            copy.build(BuildingType.Barracks)
        }
        
        if has(building: BuildingType.CityWalls) {
            copy.build(BuildingType.CityWalls)
        }
        
        if has(building: BuildingType.Granary) {
            copy.build(BuildingType.Granary)
        }
        
        if has(wonder: WonderType.HangingGardens) {
            copy.build(WonderType.HangingGardens)
        }
        
        if has(building: BuildingType.Harbor) {
            copy.build(BuildingType.Harbor)
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
        switch building {
        case BuildingType.Barracks:
            return barracks != nil
        case BuildingType.CityWalls:
            return cityWalls != nil
        case BuildingType.Granary:
            return granary != nil
        case BuildingType.Harbor:
            return harbor != nil
        case BuildingType.Palace:
            return palace != nil
        default:
            return false
        }
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
