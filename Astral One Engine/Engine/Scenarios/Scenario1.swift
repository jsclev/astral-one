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
                print("Spawned \(player.name) at \(spawnPosition.position)")
                
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
                
                let cityAgent = try CityAgent.getAgent(game: game,
                                                       player: game.currentPlayer,
                                                       city: createCity.city)
                let cityAgentCmd = cityAgent.getNextCommand()
                errorCheck(cityAgentCmd.execute())
                
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
        
        while game.turnIndex < 2 {
            let agent = try AIPlayerAgent(game: game, player: game.currentPlayer)
            try agent.processPlayerTurn()
        }

    }
}
