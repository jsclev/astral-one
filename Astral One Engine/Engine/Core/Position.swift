import Foundation

public struct Position: Equatable, Hashable {
    public let row: Int
    public let col: Int
    public static let zero: Position = Position(row: 0, col: 0)
    
    public init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    public static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
    
    public func distance(from: Position) -> Int {
        if self == from {
            return 0
        }
        
        return abs(row - from.row) + abs(col - from.col)
    }
}
