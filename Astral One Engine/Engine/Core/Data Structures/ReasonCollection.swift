import Foundation

public class Score {
    public var reasons: [Reason] = []
    
    public init() {
        
    }
    
    public var value: Double {
        var val = 0.0
        
        for reason in reasons {
            val += reason.value
        }
        
        return val
    }
}
