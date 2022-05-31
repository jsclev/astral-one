import Foundation

public class AISkillLevel {
    public let id: Int
    public let skillLevel: SkillLevel
    public let name: String
    
    public init(id: Int, skillLevel: SkillLevel, name: String) {
        self.id = id
        self.skillLevel = skillLevel
        self.name = name
    }
}
