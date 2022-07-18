import Foundation

public struct PositionScore {
    let position: Position
    let score: Utility
    
    public init(position: Position, score: Utility) {
        self.position = position
        self.score = score
    }
}
