import Foundation

public class Utility {
    public var reasons: [Reason] = []
    
    public init() {
        
    }
    
    public var score: Double {
        var val = 0.0
        
        for reason in reasons {
            val += reason.score
        }
        
        return val
    }
}
