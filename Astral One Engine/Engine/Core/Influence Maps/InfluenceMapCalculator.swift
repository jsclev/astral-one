import Foundation

public protocol InfluenceMapCalculator {
    func getInfluenceMap() throws -> [[Double]]
    static func sum(map1: [[Double]], map2: [[Double]]) -> [[Double]]
}

