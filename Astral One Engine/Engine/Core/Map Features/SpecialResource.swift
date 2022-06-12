import Foundation

public class SpecialResource: Equatable {
    public let id: Int
    public let tiledId: Int
    public let name: String
    public let type: SpecialResourceType
    
    public init(id: Int,
                tiledId: Int,
                name: String,
                type: SpecialResourceType) {
        self.id = id
        self.tiledId = tiledId
        self.name = name
        self.type = type
    }
    
    public var description: String {
        return "{id: \(id), name: \"\(name)\"}"
    }
    
    public static func == (lhs: SpecialResource, rhs: SpecialResource) -> Bool {
        return lhs.id == rhs.id
    }
}
