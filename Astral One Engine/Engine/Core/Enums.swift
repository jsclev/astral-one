import CoreGraphics

public enum Layer {
    public static let base = 0.0
    public static let terrain = 100.0
    public static let rivers = 150.0
    public static let cities = 200.0
    public static let cityNames = 250.0
    public static let specialResources = 275.0
    public static let tileStats = 285.0
    public static let units = 300.0
    public static let unitPath = 400.0
    public static let unitPath2 = 450.0
    public static let contextMenu = 475.0
    public static let contextMenuItem = 480.0
    public static let hud = 500.0
    public static let foreground = 600.0
}

public enum SkillLevel {
    case One
    case Two
    case Three
    case Four
    case Five
    case Six
    case Seven
    case Eight
}

public enum DifficultyLevel {
    case Easy
    case Normal
    case Hard
    case Ludicrous
}

public enum DiplomacyStatus {
    case Same
    case Ally
    case DeclaredFriend
    case Friendly
    case Neutral
    case Unfriendly
    case Denounced
    case AtWar
}

public enum Government {
    case Anarchy
    case Despotism
    case Monarchy
    case Communism
    case Fundamentalism
    case Republic
    case Democracy
}

public enum BuildingType {
    case Airport
    case Aqueduct
    case Bank
    case Barracks
    case Capitalization
    case Cathedral
    case CityWalls
    case CoastalFortress
    case Colosseum
    case Courthouse
    case Factory
    case Granary
    case Harbor
    case HydroPlant
    case Library
    case ManufacturingPlant
    case Marketplace
    case MassTransit
    case NuclearPlant
    case OffshorePlatform
    case Palace
    case PoliceStation
    case PortFacility
    case PowerPlant
    case RecyclingCenter
    case ResearchLab
    case SAMMissileBattery
    case SDIDefense
    case SSComponent
    case SSModule
    case SSStructural
    case SewerSystem
    case SolarPlant
    case StockExchange
    case Superhighways
    case Supermarket
    case Temple
    case University
}

public enum WonderType {
    case AdamSmithsTradingCo
    case ApolloProgram
    case Colossus
    case CopernicusObservatory
    case CureForCancer
    case DarwinsVoyage
    case EiffelTower
    case GreatLibrary
    case GreatWall
    case HangingGardens
    case HooverDam
    case IsaacNewtonsCollege
    case JSBachsCathedral
    case KingRichardsCrusade
    case LeonardosWorkshop
    case Lighthouse
    case MagellansExpedition
    case ManhattenProject
    case MarcoPolosEmbassy
    case MichelangelosChapel
    case Oracle
    case Pyramids
    case SETIProgram
    case ShakespearesTheatre
    case StatueOfLiberty
    case SunTzusWarAcademy
    case UnitedNations
    case WomensSuffrage
    
}

public enum ImprovementType {
    case Airbase
    case Farmland
    case Fortress
    case Mine
    case Pollution
    case Railroad
    case Road
}

public enum RoadType {
    case None
    case Road
    case Railroad
}

public enum SpecialResourceType: CustomStringConvertible {
    case Buffalo
    case Coal
    case Fish
    case Fruit
    case Furs
    case Game
    case Gems
    case Gold
    case Iron
    case Ivory
    case Oasis
    case Oil
    case Peat
    case Pheasant
    case Silk
    case Spice
    case Whales
    case Wheat
    case Wine
    
    public var description : String {
        switch self {
        case .Buffalo: return "Buffalo"
        case .Coal: return "Coal"
        case .Fish: return "Fish"
        case .Fruit: return "Fruit"
        case .Furs: return "Furs"
        case .Game: return "Game"
        case .Gems: return "Gems"
        case .Gold: return "Gold"
        case .Iron: return "Iron"
        case .Ivory: return "Ivory"
        case .Oasis: return "Oasis"
        case .Oil: return "Oil"
        case .Peat: return "Peat"
        case .Pheasant: return "Pheasant"
        case .Silk: return "Silk"
        case .Spice: return "Spice"
        case .Whales: return "Whales"
        case .Wheat: return "Wheat"
        case .Wine: return "Wine"
        }
    }
}

public enum TerrainType {
    case Desert
    case Forest
    case Glacier
    case Grassland
    case Hills
    case Jungle
    case Mountains
    case Ocean
    case Plains
    case Swamp
    case Tundra
    case Unknown
}

public enum Visibility {
    case FogOfWar
    case SemiRevealed
    case FullyRevealed
}

public enum AdvanceType {
    case AdvancedFlight
    case Alphabet
    case AmphibiousWarfare
    case Astronomy
    case AtomicTheory
    case Automobile
    case Banking
    case BridgeBuilding
    case BronzeWorking
    case CeremonialBurial
    case Chemistry
    case Chivalry
    case CodeOfLaws
    case CombinedArms
    case Combustion
    case Communism
    case Computers
    case Conscription
    case Construction
    case Corporation
    case Currency
    case Democracy
    case Economics
    case Electricity
    case Electronics
    case Engineering
    case Environmentalism
    case Error
    case Espionage
    case Explosives
    case Feudalism
    case Flight
    case Fundamentalism
    case FusionPower
    case FutureTechnology
    case GeneticEngineering
    case GuerrillaWarfare
    case Gunpowder
    case HorsebackRiding
    case Industrialization
    case Invention
    case IronWorking
    case LaborUnion
    case Laser
    case Leadership
    case Literacy
    case MachineTools
    case Magnetism
    case MapMaking
    case Masonry
    case MassProduction
    case Mathematics
    case Medicine
    case Metallurgy
    case Miniaturization
    case MobileWarfare
    case Monarchy
    case Monotheism
    case Mysticism
    case Navigation
    case NuclearFission
    case NuclearPower
    case Philosophy
    case Physics
    case Plastics
    case Polytheism
    case Pottery
    case Radio
    case Railroad
    case Recycling
    case Refining
    case Refrigeration
    case Republic
    case Robotics
    case Rocketry
    case Sanitation
    case Seafaring
    case SpaceFlight
    case Stealth
    case SteamEngine
    case Steel
    case Superconductor
    case Tactics
    case Theology
    case TheoryOfGravity
    case Trade
    case University
    case WarriorCode
    case Wheel
    case Writing
}
