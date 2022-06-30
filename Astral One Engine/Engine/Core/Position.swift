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
    
    public func distance(to: Position) -> Int {
        if self == to {
            return 0
        }
        
        let rowDiff = abs(to.row - row)
        let colDiff = abs(to.col - col)
        
        if rowDiff > colDiff {
            return colDiff + (rowDiff - colDiff)
        }
        else {
            return rowDiff + (colDiff - rowDiff)
        }
    }
}
