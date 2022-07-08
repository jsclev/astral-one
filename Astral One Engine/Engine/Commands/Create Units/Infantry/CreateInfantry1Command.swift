import Foundation

public class CreateInfantry1Command: Command {
    public private(set) var infantry1: Infantry1?
    public let city: City
    
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
                   turn: turn,
                   ordinal: ordinal,
                   cost: cost)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func execute(save: Bool) -> CommandResult {
        infantry1 = Infantry1(game: player.game,
                            player: player,
                            theme: player.game.theme,
                            name: "Infantry1-\(Int.random(in: 0..<500))",
                            position: city.position)
        
        if commandId == Constants.noId {
            do {
                infantry1 = try player.game.db.createUnitCommandDao.insert(command: self)
            }
            catch {
                print(error)
            }
        }
        
        if let newUnit = infantry1 {
            player.add(unit: newUnit)
            
            return CommandResult(status: CommandStatus.Ok, message: "Success")
        }
        
        return CommandResult(status: CommandStatus.Invalid, message: "Some type of error occurred")
    }
}
