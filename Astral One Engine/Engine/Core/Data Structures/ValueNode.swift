import Foundation

public class ValueNode: Hashable {
    public let row: Int
    public let col: Int
    private var value: Double = 0.0
    public var parent: ValueNode? = nil
    
    public init(row: Int, col: Int, value: Double) {
        self.row = row
        self.col = col
        self.value = value
    }
    
    public var description: String {
        return "(\(row), \(col)): \(value)"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
    
    public static func == (lhs: ValueNode, rhs: ValueNode) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
    
    public static func <(lhs: ValueNode, rhs: ValueNode) -> Bool {
        return lhs.row < rhs.row && lhs.col < rhs.col
    }
    
    public static func >(lhs: ValueNode, rhs: ValueNode) -> Bool {
        return lhs.row > rhs.row && lhs.col > rhs.col
    }
    
    public func add(value: Double) {
        self.value += value
    }
    
    public func getValue() -> Double {
        return value
    }
    
}
