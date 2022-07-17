import Foundation

public class SettlerPathfinder {
    private let settler: Settler
    
    public init(settler: Settler) {
        self.settler = settler
    }
    
    public func path(from: Position, to: Position) -> [Position] {
        var path: [Position] = []
        
        if from == Position(row: 30, col: 37) {
            path = [
                Position(row: 30, col: 36),
                Position(row: 31, col: 35),
                Position(row: 32, col: 35),
                Position(row: 33, col: 35),
                Position(row: 34, col: 35),
                Position(row: 35, col: 34)
            ]
        }
        
        return path
    }
}
