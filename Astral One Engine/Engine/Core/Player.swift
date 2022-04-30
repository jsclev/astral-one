import Foundation

public class Player {
    public let playerId: Int
    public var founders: [Founder] = []
    public var units: [Unit] = []
    
    public init(playerId: Int) {
        self.playerId = playerId
    }
    
    public func addFounder(founder: Founder) {
        founders.append(founder)
    }
}
