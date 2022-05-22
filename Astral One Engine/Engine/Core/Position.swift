import Foundation

public struct Position: Equatable {
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
    
}
