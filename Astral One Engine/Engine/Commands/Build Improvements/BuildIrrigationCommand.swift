import Foundation

public class BuildFarmlandCommand: Command {
    private let city: City
    private let unit: Unit
    private let position: Position
    
    public init(commandId: Int,
                game: Game,
                turn: Turn,
                player: Player,
                ordinal: Int,
                city: City,
                unit: Unit,
                position: Position) {
        self.city = city
        self.unit = unit
        self.position = position
        
        super.init(commandId: commandId,
                   player: player,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() -> CommandResult {
        city.build(improvement: ImprovementType.Farmland, position: position)
        
        return CommandResult(status: CommandStatus.Ok, message: "Success")
    }
}
