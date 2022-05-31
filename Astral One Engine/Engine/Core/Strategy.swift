import Foundation

public struct PlayerStrategy {
    public let attack: Double
    public let groundDefense: Double
    public let navalDefense: Double
    public let production: Double
    public let science: Double
    public let trade: Double
    
    public init(attack: Double,
                groundDefense: Double,
                navalDefense: Double,
                production: Double,
                science: Double,
                trade: Double) {
        self.attack = attack
        self.groundDefense = groundDefense
        self.navalDefense = navalDefense
        self.production = production
        self.science = science
        self.trade = trade
    }
}

public struct CityStrategy {
    public let groundDefense: Double
    public let navalDefense: Double
    public let production: Double
    public let population: Double
    public let science: Double
    public let trade: Double
}
