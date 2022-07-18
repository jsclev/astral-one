import Foundation

public class Scenario1 {
    private var cmdIndex = 0
    private var commands: [[Command]] = [[]]
    
    public init() {
        
    }
    
    public static func run(game: Game) {
        print("Running commands for player \(game.currentPlayer.name)")
        let startTile = game.currentPlayer.map.tile(at: Position(row: 32, col: 36))
        let createSettler1 = CreateSettlerCommand(db: game.db,
                                                  player: game.currentPlayer,
                                                  turn: game.currentTurn,
                                                  tile: startTile)
        errorCheck(createSettler1.execute())
        
        if let settler1 = createSettler1.settler {
            let mvUnit = MoveUnitCommand(db: game.db,
                                         player: game.currentPlayer,
                                         turn: game.currentTurn,
                                         unit: settler1,
                                         to: Position(row: settler1.position.row + 1,
                                                      col: settler1.position.col - 1))
            errorCheck(mvUnit.execute())
            
            let createCity1 = CreateCityCommand(db: game.db,
                                                player: game.currentPlayer,
                                                turn: game.currentTurn,
                                                cost: 1,
                                                cityCreator: settler1,
                                                cityName: "Chicago")
            errorCheck(createCity1.execute())
            
            let research1 = ResearchAdvanceCommand(db: game.db,
                                                   player: game.currentPlayer,
                                                   turn: game.currentTurn,
                                                   cost: 1,
                                                   advanceType: AdvanceType.Pottery)
            errorCheck(research1.execute())
            
            let turnCmd = EndPlayerTurnCommand(db: game.db,
                                               player: game.currentPlayer,
                                               turn: game.currentTurn)
            errorCheck(turnCmd.execute())
        }
        
        print("Running commands for player \(game.currentPlayer.name)")
        let createSettler2 = CreateSettlerCommand(
            db: game.db,
            player: game.currentPlayer,
            turn: game.currentTurn,
            tile: game.currentPlayer.map.tile(at: Position(row: 37, col: 36)))
        errorCheck(createSettler2.execute())
        
        if let settler2 = createSettler2.settler {
            let mvUnit = MoveUnitCommand(db: game.db,
                                         player: game.currentPlayer,
                                         turn: game.currentTurn,
                                         unit: settler2,
                                         to: Position(row: settler2.position.row + 1,
                                                      col: settler2.position.col - 1))
            errorCheck(mvUnit.execute())
            
            let alphabet = ResearchAdvanceCommand(db: game.db,
                                                  player: game.currentPlayer,
                                                  turn: game.currentTurn,
                                                  cost: 1,
                                                  advanceType: AdvanceType.Alphabet)
            errorCheck(alphabet.execute())
            
            let turnCmd = EndPlayerTurnCommand(db: game.db,
                                               player: game.currentPlayer,
                                               turn: game.currentTurn)
            errorCheck(turnCmd.execute())
        }
        
        let turn3Cmd = EndPlayerTurnCommand(db: game.db,
                                           player: game.currentPlayer,
                                           turn: game.currentTurn)
        errorCheck(turn3Cmd.execute())
        
        let turn4Cmd = EndPlayerTurnCommand(db: game.db,
                                           player: game.currentPlayer,
                                           turn: game.currentTurn)
        errorCheck(turn4Cmd.execute())
        
        let turn5Cmd = EndPlayerTurnCommand(db: game.db,
                                            player: game.currentPlayer,
                                            turn: game.currentTurn)
        errorCheck(turn5Cmd.execute())
        
        let turn6Cmd = EndPlayerTurnCommand(db: game.db,
                                            player: game.currentPlayer,
                                            turn: game.currentTurn)
        errorCheck(turn6Cmd.execute())
        
        print(game.currentPlayer)
        
        
        //        let createCity1 = CreateCityCommand(player: player,
        //                                           turn: game.currentTurn,
        //                                           cost: 1,
        //                                           cityCreator: settler1,
        //                                           cityName: "Chicago")
        //        errorCheck(createCity1.execute(save: true))
        //
        //        if let city1 = createCity1.city {
        //            let buildBarracks1 = BuildBuildingCommand(player: player,
        //                                                      turn: game.currentTurn,
        //                                                      cost: 1,
        //                                                      city: city1,
        //                                                      buildingType: BuildingType.Barracks)
        //            errorCheck(buildBarracks1.execute(save: true))
        //
        //        }
        
        
    }
    
    
    private static func errorCheck(_ commandResult: CommandResult) {
        if commandResult.status != CommandStatus.Ok {
            fatalError(commandResult.message)
        }
    }
}
