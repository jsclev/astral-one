import Foundation

public enum CommandStatus {
    case Ok
    case Invalid
}

public class CommandResult {
    public let status: CommandStatus
    public let message: String
    
    public init(status: CommandStatus, message: String) {
        self.status = status
        self.message = message
    }
}
