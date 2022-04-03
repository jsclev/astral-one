import Foundation

public class Turn: CustomStringConvertible {
    public let id: Int
    public let year: Int
    public let ordinal: Int
    public let displayText: String
    
    public var description: String {
        return "{id: \(id), year: \(year), ordinal: \(ordinal), displayText: \"\(displayText)\"}"
    }

    init(id: Int, year: Int, ordinal: Int, displayText: String) {
        self.id = id
        self.year = year
        self.ordinal = ordinal
        self.displayText = displayText
    }
}