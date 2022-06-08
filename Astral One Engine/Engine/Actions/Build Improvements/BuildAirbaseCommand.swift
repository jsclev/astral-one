import Foundation

public class BuildAirbaseCommand: Command {
    private let city: City
    private let unit: Unit
    private let position: Position
    
    public init(commandId: Int,
                game: Game,
                turn: Turn,
                player: Player,
                type: CommandType,
                ordinal: Int,
                city: City,
                unit: Unit,
                position: Position) {
        self.city = city
        self.unit = unit
        self.position = position
        
        super.init(commandId: commandId,
                   player: player,
                   type: type,
                   turn: turn,
                   ordinal: ordinal,
                   cost: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        city.build(improvement: ImprovementType.Airbase, position: position)
    }
}
