import Foundation

public class Scenario1 {
    private var cmdIndex = 0
    private var commands: [[Command]] = [[]]
    
    public init() {
        
    }
    
    private static func errorCheck(_ commandResult: CommandResult) {
        if commandResult.status != CommandStatus.Ok {
            fatalError(commandResult.message)
        }
    }
    
    public static func run(game: Game) throws {
        let spawnAgent = try SpawnPositionsAgent(game: game)
        let spawnPositions = try spawnAgent.getSpawnPositions()
        
        for player in game.players {
            if let spawnPosition = spawnPositions[player] {
                let cmd = CreateSettlerCommand(db: game.db,
                                               player: player,
                                               turn: game.currentTurn,
                                               tile: player.map.tile(at: spawnPosition.position))
                errorCheck(cmd.execute())
                
                let createCity = CreateCityCommand(db: game.db,
                                                    player: game.currentPlayer,
                                                    turn: game.currentTurn,
                                                   cityCreator: cmd.settler,
                                                    cityName: "Chicago")
                errorCheck(createCity.execute())
                
                if let city = createCity.city {
                    let cityAgent = try CityAgent.getAgent(game: game,
                                                           player: game.currentPlayer,
                                                           city: city)
                    let cityAgentCmd = cityAgent.getNextCommand()
                    errorCheck(cityAgentCmd.execute())
                }
                
                let research = ResearchAdvanceCommand(db: game.db,
                                                       player: game.currentPlayer,
                                                       turn: game.currentTurn,
                                                       advanceType: AdvanceType.Pottery)
                errorCheck(research.execute())
    
                let turnCmd = EndPlayerTurnCommand(db: game.db,
                                                   player: game.currentPlayer,
                                                   turn: game.currentTurn)
                errorCheck(turnCmd.execute())
            }
            else {
                fatalError("No spawn position for \(player.name).")
            }
        }
        
        while game.turnIndex < game.turns.count - 20 {
            print("----------------------------------------------------")
            print("Starting turn \(game.currentTurn.ordinal) for \(game.currentPlayer.name)...")
            let agent = try AIPlayerAgent(game: game, player: game.currentPlayer)
            let cmds = try agent.getNextCommands()
            
            for cmd in cmds {
                errorCheck(cmd.execute())
                print(cmd.debugText)
            }
        }
        

    
        //
        //        if let settler1 = createSettler1.settler {
        //            let mvUnit = MoveUnitCommand(db: game.db,
        //                                         player: game.currentPlayer,
        //                                         turn: game.currentTurn,
        //                                         unit: settler1,
        //                                         to: Position(row: settler1.position.row + 1,
        //                                                      col: settler1.position.col - 1))
        //            errorCheck(mvUnit.execute())
        //
        //            let createCity1 = CreateCityCommand(db: game.db,
        //                                                player: game.currentPlayer,
        //                                                turn: game.currentTurn,
        //                                                cityCreator: settler1,
        //                                                cityName: "Chicago")
        //            errorCheck(createCity1.execute())
        //
        //            if let city = createCity1.city {
        //                let cityAgent = try CityAgent.getAgent(game: game,
        //                                                       player: game.currentPlayer,
        //                                                       city: city)
        //                let cityAgentCmd = cityAgent.getNextCommand()
        //                errorCheck(cityAgentCmd.execute())
        //            }
        //
        //            let research1 = ResearchAdvanceCommand(db: game.db,
        //                                                   player: game.currentPlayer,
        //                                                   turn: game.currentTurn,
        //                                                   advanceType: AdvanceType.Pottery)
        //            errorCheck(research1.execute())
        //
        //            let turnCmd = EndPlayerTurnCommand(db: game.db,
        //                                               player: game.currentPlayer,
        //                                               turn: game.currentTurn)
        //            errorCheck(turnCmd.execute())
        //        }
        //

        
    }
}
