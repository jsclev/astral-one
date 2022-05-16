import Foundation

public class BuildCityCommand: Command {
    private let unit: Unit
    private let position: Position
    
    public init(commandId: Int,
                game: Game,
                turn: Turn,
                player: Player,
                type: CommandType,
                ordinal: Int,
                unit: Unit,
                position: Position) {
        self.unit = unit
        self.position = position
        
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
        let city = City(player: player,
                        theme: game.theme,
                        name: "New City",
                        assetName: "city-1",
                        position: position)
        player.add(city: city)
    }
}
