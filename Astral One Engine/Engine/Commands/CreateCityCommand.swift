import Foundation

public class CreateCityCommand: Command {
    private let city: City
    
    public init(commandId: Int,
                gameId: Int,
                turn: Turn,
                player: Player,
                type: CommandType,
                ordinal: Int,
                city: City,
                position: Position) {
        self.city = city
        
        super.init(commandId: commandId,
                   gameId: gameId,
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
