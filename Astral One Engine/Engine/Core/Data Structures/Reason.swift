import Foundation

public enum ReasonType {
    case BasicResources
    case Defense
    case DistanceToTargetTile
    case FoodSource
    case InvalidCityLocation
    case OceanAccess
    case OnCoast
    case OnRiver
    case ProductionSource
    case ProximityToNearestCity
    case ProximityToWater
    case RiverWithinCityRadius
    case TileNotRevealed
    case TradeSource
    case ValidCityLocation
}

public class Reason: CustomStringConvertible {
    public let reasonType: ReasonType
    public let score: Double
    public let message: String
    
    public init(reasonType: ReasonType, value: Double, message: String) {
        self.reasonType = reasonType
        self.score = value
        self.message = message
    }
    
    public var description: String {
        return "{type: \(reasonType), value: \(score), message: \(message)}"
    }
    
}
