import Foundation

public class Civilization: CustomStringConvertible {
    public let id: Int
    public let name: String
    public let color: String
    
    public var description: String {
        return "{id: \(id), name: \"\(name)\", color: \"\(color)\"}"
    }
    
    public init(id: Int, name: String, color: String) {
        self.id = id
        self.name = name
        self.color = color
    }
}


