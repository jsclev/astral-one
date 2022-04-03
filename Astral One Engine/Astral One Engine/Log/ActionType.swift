import Foundation

public class ActionType: CustomStringConvertible {
    public let id: Int
    public let name: String
    
    public var description: String {
        return "{id: \(id), name: \"\(name)\"}"
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
