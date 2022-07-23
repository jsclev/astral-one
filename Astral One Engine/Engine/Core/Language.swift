import Foundation

public class Language: CustomStringConvertible {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    public var description: String {
        return "{id: \(id), name: \"\(name)\"}"
    }
}


