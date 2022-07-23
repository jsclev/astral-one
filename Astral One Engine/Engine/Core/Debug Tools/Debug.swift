import Foundation

public class Debug {
    public private (set) var counter: Int = 0

    public static let shared = Debug()
    
    private init() {}
    
    public func bumpCounter() {
        counter += 1
    }
    
    public func reset() {
        counter = 0
    }
    
}
