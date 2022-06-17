import Foundation

public class CreateEngineerCommand: Command {
    private let city: City
    public private(set) var engineer: Engineer?

    public convenience init(player: Player,
                            turn: Turn,
                            ordinal: Int,
                            cost: Int,
                            city: City) {
        self.init(commandId: Constants.noId,
                  player: player,
                  turn: turn,
                  ordinal: ordinal,
                  cost: cost,
                  city: city)
    }
    
    public init(commandId: Int,
                player: Player,
                turn: Turn,
                ordinal: Int,
                cost: Int,
                city: City) {
        self.city = city
        
        super.init(commandId: commandId,
                   player: player,
                   type: CommandType(id: Constants.noId, name: ""),
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute() {
        engineer = Engineer(game: player.game,
                            player: player,
                            theme: player.game.theme,
                            name: "Engineer",
                            position: city.position)
        
        if commandId == Constants.noId {
            do {
                engineer = try player.game.db.createUnitCommandDao.insert(command: self)
            }
            catch {
                print(error)
            }
        }
        
        if let e = engineer {
            player.add(unit: e)
        }
    }
}
