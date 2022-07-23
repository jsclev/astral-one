import Foundation

public class Civilization: CustomStringConvertible {
    public let id: Int
    public let name: String
    public let language: Language
    public let color: String
    public let cityNames: [String]

    public init(id: Int,
                name: String,
                language: Language,
                color: String,
                cityNames: [String]) {
        self.id = id
        self.name = name
        self.language = language
        self.color = color
        self.cityNames = cityNames
    }
    
    public var description: String {
        return "{id: \(id), name: \"\(name)\", language: \(language), color: \"\(color)\"}"
    }
}


