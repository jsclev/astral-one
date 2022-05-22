import Foundation

public struct PlayerStrategy {
    public let attack: Double
    public let groundDefense: Double
    public let navalDefense: Double
    public let production: Double
    public let science: Double
    public let trade: Double
}

public struct CityStrategy {
    public let groundDefense: Double
    public let navalDefense: Double
    public let production: Double
    public let population: Double
    public let science: Double
    public let trade: Double
}
