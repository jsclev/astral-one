import Foundation
import CoreImage

public class Advance {
    public let type: AdvanceType
    public let parents: [Advance]
    @Published public var completed = false
    @Published public var isResearching = false
    
    public init(type: AdvanceType, parents: [Advance]) {
        self.type = type
        self.parents = parents
    }
}
