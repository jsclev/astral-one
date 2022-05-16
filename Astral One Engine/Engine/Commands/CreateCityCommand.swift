import Foundation

public class CreateCityCommand: Command {
    private let city: City
    
    public init(commandId: Int,
                game: Game,
                turn: Turn,
                player: Player,
                type: CommandType,
                ordinal: Int,
                city: City,
                position: Position) {
        self.city = city
        
        super.init(commandId: commandId,
                   game: game,
                   turn: turn,
                   player: player,
                   type: type,
                   ordinal: ordinal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        player.add(city: city)
    }
}
