import Foundation

public protocol InfluenceSpreadStrategy {
    func getInfluence(row: Int, col: Int) -> Float
}

public protocol InfluenceMapStrategy {
    func getInfluenceMap() -> [[(Float, InfluenceSpreadStrategy)]]
}
