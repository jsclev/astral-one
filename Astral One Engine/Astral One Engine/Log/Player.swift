import Foundation

public class GPlayer: CustomStringConvertible {
    public let id: Int
    public let ordinal: Int
    public let displayText: String
    public let type: String
    
    public var description: String {
        return "{id: \(id), ordinal: \(ordinal), displayText: \(displayText), type: \(type)}"
    }
    
    init(id: Int, ordinal: Int, displayText: String, type: String) {
        self.id = id
        self.ordinal = ordinal
        self.displayText = displayText
        self.type = type
    }
}
