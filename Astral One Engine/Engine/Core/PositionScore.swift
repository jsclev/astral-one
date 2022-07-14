import Foundation

public struct PositionScore {
    let position: Position
    let score: Score
    
    public init(position: Position, score: Score) {
        self.position = position
        self.score = score
    }
}
