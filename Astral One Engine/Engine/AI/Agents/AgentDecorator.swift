import Foundation

public protocol AgentDecorator {
    func getScoreMap() -> [[Score]]
}
