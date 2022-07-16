import Foundation

public class Scenario1 {
    public init() {
        
    }
    
    public func setup(game: Game, player: Player) {
//        var cmds: [Command] = []
//
//        let createSettler1 = CreateSettlerCommand(
//            player: player,
//            turn: game.currentTurn,
//            ordinal: game.currentTurn.ordinal,
//            cost: 1,
//            tile: player.map.tile(at: Position(row: 0, col: 0)))
//        errorCheck(commandResult: createSettler1.execute(save: true))
//
//        if let settler1 = createSettler1.settler {
//            //        cmds.append(MoveUnitCommand(player: player,
//            //                                    turn: game.currentTurn,
//            //                                    ordinal: 2,
//            //                                    unit: <#T##Unit#>,
//            //                                    to: <#T##Position#>))
//            //        cmds.append(CreateCityCommand(player: <#T##Player#>,
//            //                                      turn: <#T##Turn#>,
//            //                                      ordinal: <#T##Int#>,
//            //                                      cost: <#T##Int#>,
//            //                                      cityCreator: <#T##Builder#>,
//            //                                      cityName: <#T##String#>))
//        }

    }
    
    private func errorCheck(commandResult: CommandResult) {
        if commandResult.status != CommandStatus.Ok {
            fatalError(commandResult.message)
        }
    }
}
