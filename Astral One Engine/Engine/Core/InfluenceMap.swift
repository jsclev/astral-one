import Foundation

public class InfluenceMap {
    private let map: [[Float]]
    
    public init(size: Int) {
        map = Array(repeating: Array(repeating: 0.0, count: size), count: size)
    }
}
