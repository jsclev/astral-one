import Foundation

public class MoveCommand: Command {
    private let unit: Unit
    private let toPosition: String
    
    public init(unit: Unit, toPosition: String) {
        self.unit = unit
        self.toPosition = toPosition
    }
    
    public override func execute() {
        print("Executing move command")
    }
}
