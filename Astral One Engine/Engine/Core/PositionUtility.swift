import Foundation

public struct PositionUtility: CustomStringConvertible {
    let position: Position
    let utility: Utility
    
    public init(position: Position, utility: Utility) {
        self.position = position
        self.utility = utility
    }
    
    public var description: String {
        return "{position: \(position), utility: \(utility)}"
    }
}
