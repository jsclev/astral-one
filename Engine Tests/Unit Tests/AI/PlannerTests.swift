import XCTest
import Engine

class PlannerTests: XCTestCase {
    
//    func testGetActions1() throws {
//        let theme = Theme(id: 1, name: "Test Theme")
//        let map = Map(mapId: 1, width: 1, height: 1)
//        let game = Game(theme: theme, map: map, db: TestUtils.getDb())
//        let startState = Player(playerId: 1, game: game, map: map)
//        let player = startState.clone()
//
//        // Execute the sequence of actions that the planner constructed
//        for action in player.getAvailableActions() {
//            action.execute()
//        }
//
//        // We purposefully did not add any available actions, so the planner cannot do anything
//        XCTAssertEqual(player.defense, startState.defense)
//
//    }
    
//    func testGetActions100() throws {
//        let theme = Theme(id: 1, name: "Test Theme")
//        let gameMap = Map(mapId: 1, width: 3, height: 3)
//        let game = Game(theme: theme, map: gameMap, db: TestUtils.getDb())
//
//        let terrain00 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [0, 0]",
//                                type: TerrainType.Desert)
//        let terrain01 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [0, 1]",
//                                type: TerrainType.Forest)
//        let terrain02 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [0, 2]",
//                                type: TerrainType.Glacier)
//        let terrain10 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [1, 0]",
//                                type: TerrainType.Grassland)
//        let terrain11 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [1, 1]",
//                                type: TerrainType.Hills)
//        let terrain12 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [1, 2]",
//                                type: TerrainType.Jungle)
//        let terrain20 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [2, 0]",
//                                type: TerrainType.Mountains)
//        let terrain21 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [2, 1]",
//                                type: TerrainType.Plains)
//        let terrain22 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [2, 2]",
//                                type: TerrainType.Swamp)
//
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 0, col: 0), terrain: terrain00))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 0, col: 1), terrain: terrain01))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 0, col: 2), terrain: terrain02))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 1, col: 0), terrain: terrain10))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 1, col: 1), terrain: terrain11))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 1, col: 2), terrain: terrain12))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 2, col: 0), terrain: terrain20))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 2, col: 1), terrain: terrain21))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 2, col: 2), terrain: terrain22))
//
//        let p1Map = Map(mapId: 2, width: gameMap.width, height: gameMap.height)
//        let p2Map = Map(mapId: 3, width: gameMap.width, height: gameMap.height)
//
//        for row in 0..<gameMap.height {
//            for col in 0..<gameMap.width {
//                let position = Position(row: row, col: col)
//                let tile = gameMap.tile(at: position)
//                p1Map.add(tile: Tile(id: tile.id,
//                                     position: tile.position,
//                                     terrain: tile.terrain))
//                p1Map.tile(at: position).set(visibility: Visibility.FullyRevealed)
//
//                p2Map.add(tile: Tile(id: 100 + tile.id,
//                                     position: tile.position,
//                                     terrain: tile.terrain))
//            }
//        }
//
//        let p1 = AIPlayer(playerId: 1,
//                          game: game,
//                          map: p1Map,
//                          skillLevel: SkillLevel.One,
//                          difficultyLevel: DifficultyLevel.Easy,
//                          playStyle: PlayStyle(offense: 0.0, defense: 0.0))
//
//        let p1Settler = Settler(game: game,
//                                player: p1,
//                                theme: theme,
//                                name: "Settler",
//                                position: Position(row: 0, col: 0))
//        p1.add(cityCreator: p1Settler)
//        let p1City = City(id: 1,
//                          owner: p1,
//                          theme: theme,
//                          name: "Player 1 City 1",
//                          assetName: "city-1",
//                          position: Position(row: 0, col: 0))
//
//        let createCityCmd = CreateCityCommand(player: p1,
//                                              turn: Turn(id: 1,
//                                                         year: 1,
//                                                         ordinal: 1,
//                                                         displayText: ""),
//                                              ordinal: 0,
//                                              cost: 0,
//                                              cityCreator: p1Settler,
//                                              cityName: "Test City")
//        createCityCmd.execute()
//
//        p1City.create(settler: Settler(game: game,
//                                       player: p1,
//                                       theme: theme,
//                                       name: "Settler",
//                                       position: Position(row: 0, col: 0)))
//
//        let p1Agent = try AIPlayerAgent(player: p1)
//        let p1ScoreMap = try p1Agent.settlerAgents[0].getBuildCityScoreMap()
//
//        let p2 = AIPlayer(playerId: 2,
//                          game: game,
//                          map: p2Map,
//                          skillLevel: SkillLevel.One,
//                          difficultyLevel: DifficultyLevel.Easy,
//                          playStyle: PlayStyle(offense: 0.0, defense: 0.0))
//        let p2Settler = Settler(game: game,
//                                player: p2,
//                                theme: theme,
//                                name: "Settler",
//                                position: Position(row: 0, col: 0))
//        let p2SettlerAgent = try SettlerAgent(player: p2, settler: p2Settler)
//        let p2ScoreMap = try p2SettlerAgent.getBuildCityScoreMap()
//
//        XCTAssertEqual(p1ScoreMap[0][0], 2.0)
//        XCTAssertEqual(p1ScoreMap[0][1], 4.5)
//        XCTAssertEqual(p1ScoreMap[0][2], 1.0)
//        XCTAssertEqual(p1ScoreMap[1][0], 3.0)
//        XCTAssertEqual(p1ScoreMap[1][1], 3.0)
//        XCTAssertEqual(p1ScoreMap[1][2], 2.5)
//        XCTAssertEqual(p1ScoreMap[2][0], 4.0)
//        XCTAssertEqual(p1ScoreMap[2][1], 3.0)
//        XCTAssertEqual(p1ScoreMap[2][2], 2.5)
//
//        XCTAssertEqual(p2ScoreMap[0][0], 1.0)
//        XCTAssertEqual(p2ScoreMap[0][1], 1.0)
//        XCTAssertEqual(p2ScoreMap[0][2], 1.0)
//        XCTAssertEqual(p2ScoreMap[1][0], 1.0)
//        XCTAssertEqual(p2ScoreMap[1][1], 1.0)
//        XCTAssertEqual(p2ScoreMap[1][2], 1.0)
//        XCTAssertEqual(p2ScoreMap[2][0], 1.0)
//        XCTAssertEqual(p2ScoreMap[2][1], 1.0)
//        XCTAssertEqual(p2ScoreMap[2][2], 1.0)
//
//    }
    
//    func testGetActions101() throws {
//        let theme = Theme(id: 1, name: "Test Theme")
//        let gameMap = Map(mapId: 1, width: 3, height: 3)
//        let game = Game(theme: theme, map: gameMap, db: TestUtils.getDb())
//
//        let terrain00 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [0, 0]",
//                                type: TerrainType.Desert)
//        let terrain01 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [0, 1]",
//                                type: TerrainType.Forest)
//        let terrain02 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [0, 2]",
//                                type: TerrainType.Glacier)
//        let terrain10 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [1, 0]",
//                                type: TerrainType.Grassland)
//        let terrain11 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [1, 1]",
//                                type: TerrainType.Hills)
//        let terrain12 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [1, 2]",
//                                type: TerrainType.Jungle)
//        let terrain20 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [2, 0]",
//                                type: TerrainType.Mountains)
//        let terrain21 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [2, 1]",
//                                type: TerrainType.Plains)
//        let terrain22 = Terrain(id: 1,
//                                tiledId: 1,
//                                name: "Terrain [2, 2]",
//                                type: TerrainType.Swamp)
//
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 0, col: 0), terrain: terrain00))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 0, col: 1), terrain: terrain01))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 0, col: 2), terrain: terrain02))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 1, col: 0), terrain: terrain10))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 1, col: 1), terrain: terrain11))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 1, col: 2), terrain: terrain12))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 2, col: 0), terrain: terrain20))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 2, col: 1), terrain: terrain21))
//        gameMap.add(tile: Tile(id: 1, position: Position(row: 2, col: 2), terrain: terrain22))
//
//        let p1Map = Map(mapId: 2, width: gameMap.width, height: gameMap.height)
//        let p2Map = Map(mapId: 3, width: gameMap.width, height: gameMap.height)
//
//        for row in 0..<gameMap.height {
//            for col in 0..<gameMap.width {
//                let position = Position(row: row, col: col)
//                let tile = gameMap.tile(at: position)
//                p1Map.add(tile: Tile(id: tile.id,
//                                     position: tile.position,
//                                     terrain: tile.terrain))
//                p1Map.tile(at: position).set(visibility: Visibility.FullyRevealed)
//
//                p2Map.add(tile: Tile(id: 100 + tile.id,
//                                     position: tile.position,
//                                     terrain: tile.terrain))
//            }
//        }
//
//        let p1 = AIPlayer(playerId: 1,
//                          game: game,
//                          map: p1Map,
//                          skillLevel: SkillLevel.Two,
//                          difficultyLevel: DifficultyLevel.Easy,
//                          playStyle: PlayStyle(offense: 0.0, defense: 0.0))
//        let p2 = AIPlayer(playerId: 2,
//                          game: game,
//                          map: p2Map,
//                          skillLevel: SkillLevel.Two,
//                          difficultyLevel: DifficultyLevel.Easy,
//                          playStyle: PlayStyle(offense: 0.0, defense: 0.0))
//
//        //        let strategy = PlayerStrategy(attack: 10.0,
//        //                                      groundDefense: 20.0,
//        //                                      navalDefense: 20.0,
//        //                                      production: 25.0,
//        //                                      science: 25.0,
//        //                                      trade: 25.0)
//
//        let p1Settler = Settler(game: game,
//                                player: p1,
//                                theme: theme,
//                                name: "Settler",
//                                position: Position(row: 0, col: 0))
//        let p1SettlerAgent = try SettlerAgent(player: p1, settler: p1Settler)
//        let p1ScoreMap = try p1SettlerAgent.getBuildCityScoreMap()
//
//        let p2Settler = Settler(game: game,
//                                player: p2,
//                                theme: theme,
//                                name: "Settler",
//                                position: Position(row: 0, col: 0))
//        let p2SettlerAgent = try SettlerAgent(player: p2, settler: p2Settler)
//        let p2ScoreMap = try p2SettlerAgent.getBuildCityScoreMap()
//
//        XCTAssertEqual(p1ScoreMap[0][0], 2.0)
//        XCTAssertEqual(p1ScoreMap[0][1], 4.5)
//        XCTAssertEqual(p1ScoreMap[0][2], 1.0)
//        XCTAssertEqual(p1ScoreMap[1][0], 3.0)
//        XCTAssertEqual(p1ScoreMap[1][1], 3.0)
//        XCTAssertEqual(p1ScoreMap[1][2], 2.5)
//        XCTAssertEqual(p1ScoreMap[2][0], 4.0)
//        XCTAssertEqual(p1ScoreMap[2][1], 3.0)
//        XCTAssertEqual(p1ScoreMap[2][2], 2.5)
//
//        XCTAssertEqual(p2ScoreMap[0][0], 1.0)
//        XCTAssertEqual(p2ScoreMap[0][1], 1.0)
//        XCTAssertEqual(p2ScoreMap[0][2], 1.0)
//        XCTAssertEqual(p2ScoreMap[1][0], 1.0)
//        XCTAssertEqual(p2ScoreMap[1][1], 1.0)
//        XCTAssertEqual(p2ScoreMap[1][2], 1.0)
//        XCTAssertEqual(p2ScoreMap[2][0], 1.0)
//        XCTAssertEqual(p2ScoreMap[2][1], 1.0)
//        XCTAssertEqual(p2ScoreMap[2][2], 1.0)
//    }
    
    //    func testGetActions2() throws {
    //        let theme = Theme(id: 1, name: "test theme")
    //        let game = Game(theme: theme)
    //        let player = Player(playerId: 1)
    //        let city = City(theme: theme,
    //                        player: player,
    //                        name: "test city",
    //                        assetName: "test asset name",
    //                        position: Position(row: 0, col: 0))
    //        let playerCopy = player.clone()
    //
    //        city.addAvailable(action: CreateInfantry1Action(city: city))
    //
    //        for action in player.getAvailableActions() {
    //            action.execute(game: game, player: playerCopy)
    //        }
    //
    //        XCTAssertEqual(player.defense, 0.001)
    //        XCTAssertEqual(playerCopy.defense, 1)
    //    }
    
    //    func testGetActions3() throws {
    //        // let planner = Planner()
    //        let game = Game(theme: Theme(id: 1, name: "test theme"))
    //        let player = Player(playerId: 1)
    //
    //        player.addAvailable(action: CreateInfantry1Action())
    //        player.addAvailable(action: ResearchBronzeWorkingAction())
    //
    //        let action1 = CreateInfantry1Action()
    //        let playerClone1 = player.clone()
    //        action1.execute(game: game, player: playerClone1)
    //        let goalScorer1 = IncreaseDefenseGoalScorer()
    //
    //        XCTAssertGreaterThan(goalScorer1.getScore(game: game, start: player, end: playerClone1, cost: 1), 0)
    //    }
    
    //    func testGetActions4() throws {
    //        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
    //        let startState = Player(playerId: 1)
    //        let player = startState.clone()
    //
    //        let actionSequence: [Action] = [
    //            ResearchBronzeWorkingAction(),
    //            CreateInfantry2Action()
    //        ]
    //
    //        for action in actionSequence {
    //            action.execute(game: game, player: player)
    //        }
    //
    //        let goalScorer = IncreaseDefenseGoalScorer()
    //        let score = goalScorer.getScore(game: game, start: startState, end: player, cost: 1)
    //
    //        XCTAssertGreaterThan(score, 1000.0)
    //    }
    
    //    func testGetActions5() throws {
    //        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
    //        let goalScorer = IncreaseDefenseGoalScorer()
    //        let startState = Player(playerId: 1)
    //
    //        let player1 = startState.clone()
    //        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence1.add(action: ResearchBronzeWorkingAction())
    //        actionSequence1.add(action: CreateInfantry2Action())
    //        let score1 = actionSequence1.execute(game: game, player: player1)
    //
    //        let player2 = startState.clone()
    //        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence2.add(action: ResearchHorsebackRidingAction())
    //        actionSequence2.add(action: CreateCavalry1Action())
    //        let score2 = actionSequence2.execute(game: game, player: player2)
    //
    //        XCTAssertGreaterThan(score1, 0)
    //        XCTAssertGreaterThan(score2, 0)
    //        XCTAssertGreaterThan(score1, score2)
    //    }
    
    //    func testGetActions6() throws {
    //        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
    //        let goalScorer = IncreaseDefenseGoalScorer()
    //        let startState = Player(playerId: 1)
    //
    //        let player1 = startState.clone()
    //        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence1.add(action: ResearchBronzeWorkingAction())
    //        actionSequence1.add(action: CreateInfantry2Action())
    //        let score1 = actionSequence1.execute(game: game, player: player1)
    //
    //        let player2 = startState.clone()
    //        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence2.add(action: ResearchHorsebackRidingAction())
    //        actionSequence2.add(action: CreateCavalry1Action())
    //        let score2 = actionSequence2.execute(game: game, player: player2)
    //
    //        XCTAssertGreaterThan(score1, 0)
    //        XCTAssertGreaterThan(score2, 0)
    //        XCTAssertGreaterThan(score1, score2)
    //    }
    
    //    func testGetActions7() throws {
    //        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
    //        let goalScorer = IncreaseDefenseGoalScorer()
    //        let startState = Player(playerId: 1)
    //
    //        let player1 = startState.clone()
    //        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence1.add(action: ResearchBronzeWorkingAction())
    //        actionSequence1.add(action: CreateInfantry2Action())
    //        let score1 = actionSequence1.execute(game: game, player: player1)
    //
    //        let player2 = startState.clone()
    //        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence2.add(action: ResearchWarriorCodeAction())
    //        actionSequence2.add(action: CreateInfantry3Action())
    //        let score2 = actionSequence2.execute(game: game, player: player2)
    //
    //        XCTAssertGreaterThan(score1, 0)
    //        XCTAssertGreaterThan(score2, 0)
    //        XCTAssertGreaterThan(score1, score2)
    //    }
    
    //    func testGetActions8() throws {
    //        let theme = Theme(id: 1, name: "Test Theme")
    //        let map = Map(mapId: 1, width: 2, height: 2)
    //        let game = Game(theme: theme, map: map)
    //        let goalScorer = IncreaseDefenseGoalScorer()
    //        let startState = Player(playerId: 1, game: game)
    //
    //        let player1 = startState.clone()
    //        let city1 = City(player: player1,
    //                         theme: theme,
    //                         name: "Test City 1",
    //                         assetName: "",
    //                         position: Position(row: 0, col: 0))
    //        player1.add(city: city1)
    //        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence1.add(action: BuildBarracksAction())
    //        actionSequence1.add(action: CreateInfantry2Action(city: city1))
    //        let score1 = actionSequence1.execute(game: game, player: player1)
    //
    //        let player2 = startState.clone()
    //        let city2 = City(player: player2,
    //                         theme: theme,
    //                         name: "Test City 2",
    //                         assetName: "",
    //                         position: Position(row: 0, col: 1))
    //        player2.add(city: city2)
    //        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence2.add(action: BuildBarracksAction())
    //        actionSequence2.add(action: CreateCavalry1Action(city: city2))
    //        let score2 = actionSequence2.execute(game: game, player: player2)
    //
    //        XCTAssertGreaterThan(score1, 0)
    //        XCTAssertGreaterThan(score2, 0)
    //        XCTAssertGreaterThan(score1, score2)
    //    }
    
    //    func testGetActions9() throws {
    //        let theme = Theme(id: 1, name: "Test Theme")
    //        let map = Map(mapId: 1, width: 2, height: 2)
    //        let game = Game(theme: theme, map: map)
    //        let goalScorer = IncreaseDefenseGoalScorer()
    //        let startState = Player(playerId: 1, game: game)
    //
    //        let player1 = startState.clone()
    //        player1.add(city: City(player: player1,
    //                               theme: theme,
    //                               name: "Test City 1",
    //                               assetName: "",
    //                               position: Position(row: 0, col: 0)))
    //        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence1.add(action: CreateInfantry1Action())
    //        let score1 = actionSequence1.execute(game: game, player: player1)
    //
    //        let player2 = startState.clone()
    //        player2.add(city: City(player: player2,
    //                               theme: theme,
    //                               name: "Test City 2",
    //                               assetName: "",
    //                               position: Position(row: 0, col: 1)))
    //        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
    //        actionSequence2.add(action: CreateInfantry1Action())
    //        actionSequence2.add(action: BuildCityWallsAction(city: player2.cities[0]))
    //        let score2 = actionSequence2.execute(game: game, player: player2)
    //
    //        XCTAssertGreaterThan(score1, 0)
    //        XCTAssertGreaterThan(score2, 0)
    //        XCTAssertGreaterThan(score1, score2)
    //    }
    //
    //    func testGetActions10() throws {
    //        let theme = Theme(id: 1, name: "test theme")
    //        let map = Map(mapId: 1, width: 1, height: 1)
    //        let game = Game(theme: theme, map: map)
    //        let player = Player(playerId: 1, game: game)
    //        let city = City(player: player,
    //                        theme: theme,
    //                        name: "test city",
    //                        assetName: "city",
    //                        position: Position(row: 0, col: 0))
    //        let ai = RandomAI(game: game, player: player)
    //
    //        player.add(city: city)
    //        player.addAvailable(researchAction: ResearchPotteryAction())
    ////        player.addAvailable(researchAction: ResearchAlphabetAction())
    ////        player.addAvailable(researchAction: ResearchWarriorCodeAction())
    ////        player.addAvailable(researchAction: ResearchHorsebackRidingAction())
    ////        player.addAvailable(researchAction: ResearchBronzeWorkingAction())
    ////        player.addAvailable(researchAction: ResearchMasonryAction())
    ////        player.addAvailable(researchAction: ResearchCeremonialBurialAction())
    //        city.addAvailable(action: BuildBarracksCommand())
    //        city.addAvailable(action: CreateInfantry1Action())
    //
    //        while player.defense < 300 {
    //            for action in ai.nextActionSequence() {
    //                action.execute(game: game, player: player)
    //                print("\(action.name) executed, player defense is now \(player.defense).")
    //            }
    //        }
    //    }
    
    //    func testGetActions11() throws {
    //        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
    //        let player = Player(playerId: 1)
    //        let ai = RandomAI(game: game, player: player)
    //
    //        player.addAvailable(researchAction: ResearchWarriorCodeAction())
    //
    //        if let action = ai.nextAction() {
    //            XCTAssertEqual(action, ResearchWarriorCodeAction())
    //            action.execute(game: game, player: player)
    //        }
    //
    //
    //        if let action = ai.nextAction() {
    //            XCTAssertEqual(action, ResearchFeudalismAction())
    //            action.execute(game: game, player: player)
    //        }
    //
    //        if let action = ai.nextAction() {
    //            XCTAssertEqual(action, ResearchChivalryAction())
    //            action.execute(game: game, player: player)
    //        }
    //
    //        if let action = ai.nextAction() {
    //            XCTAssertEqual(action, ResearchLeadershipAction())
    //            action.execute(game: game, player: player)
    //        }
    //    }
    
    //    func testGetActions12() throws {
    //        let theme = Theme(id: 1, name: "test theme")
    //        let game = Game(theme: theme)
    //        let player = Player(playerId: 1)
    //        let city = City(theme: theme,
    //                        player: player,
    //                        name: "test city",
    //                        assetName: "city",
    //                        position: Position(row: 0, col: 0))
    //        let ai = RandomAI(game: game, player: player)
    //
    //        city.addAvailable(action: BuildBarracksAction(city: city))
    //
    //
    //        if let action = ai.nextAction() {
    //            action.execute(game: game, player: player)
    //            print("\(action.name) executed, player defense is now \(player.defense).")
    //        }
    //    }
    
    func testGetActions198() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(width: 8, height: 8)
        let game = try Game(gameId: 1, theme: theme, map: map, db: TestUtils.getDb())
        
        map.add(tile: TestUtils.makeTile(0, 0, TerrainType.Forest, SpecialResourceType.Pheasant))
        map.add(tile: TestUtils.makeTile(1, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(5, 0, TerrainType.Ocean))
        map.add(tile: TestUtils.makeTile(6, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(7, 0, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(5, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(6, 1, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(7, 1, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(5, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(6, 2, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(7, 2, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(5, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(6, 3, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(7, 3, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(5, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(6, 4, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(7, 4, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 5, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 5, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 5, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 5, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 5, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(5, 5, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(6, 5, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(7, 5, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 6, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 6, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 6, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 6, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 6, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(5, 6, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(6, 6, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(7, 6, TerrainType.Grassland))
        
        map.add(tile: TestUtils.makeTile(0, 7, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(1, 7, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(2, 7, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(3, 7, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(4, 7, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(5, 7, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(6, 7, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(7, 7, TerrainType.Grassland))
        
        map.revealAllTiles()
        
        let aiPlayer = AIPlayer(playerId: 1,
                                game: game,
                                map: map,
                                skillLevel: SkillLevel.One,
                                difficultyLevel: DifficultyLevel.Easy,
                                playStyle: AIStrategy.init(offense: 0.5, defense: 0.5))

        XCTAssertNil(aiPlayer.map.tile(at: Position(row: 2, col: 2)).city)
        
        XCTAssertNotNil(aiPlayer.map.tile(at: Position(row: 2, col: 2)).city)
    }
    
    func testGetActions98() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 3, height: 3)
        let game = try Game(gameId: 1, theme: theme, map: map, db: TestUtils.getDb())
        let player = Player(playerId: 1, game: game, map: map)
        let player2 = Player(playerId: 2, game: game, map: map)
        // let turn1 = Turn(id: 1, year: -4000, ordinal: 1, displayText: "4000 BC")
        
        map.add(tile: TestUtils.makeTile(0, 0, TerrainType.Grassland))
        map.add(tile: TestUtils.makeTile(0, 1, TerrainType.Forest))
        map.add(tile: TestUtils.makeTile(0, 2, TerrainType.Hills))
        map.add(tile: TestUtils.makeTile(1, 0, TerrainType.Mountains))
        map.add(tile: TestUtils.makeTile(1, 1, TerrainType.Jungle))
        map.add(tile: TestUtils.makeTile(1, 2, TerrainType.Swamp))
        map.add(tile: TestUtils.makeTile(2, 0, TerrainType.Desert))
        map.add(tile: TestUtils.makeTile(2, 1, TerrainType.Plains))
        map.add(tile: TestUtils.makeTile(2, 2, TerrainType.Tundra))
        
        var maxDefense = 0.0
        var actionPlan: [Action] = []
        var cityPosition = Position(row: 0, col: 0)
        let enemyUnit = Infantry1(game: game,
                                  player: player2,
                                  theme: theme,
                                  name: "Warrior",
                                  position: cityPosition)
        
        for row in 0..<3 {
            for col in 0..<3 {
                let turn = Turn(id: -1, year: 0, ordinal: 0, displayText: "test turn")
                let playerCopy = player.clone()
                let position = Position(row: row, col: col)
                
                let settler = Settler(game: game,
                                      player: playerCopy,
                                      theme: theme,
                                      name: "Settler",
                                      position: position)
                let city = City(id: Constants.noId,
                                owner: playerCopy,
                                theme: game.theme,
                                name: "test city",
                                assetName: "test asset name",
                                position: settler.position)
                actionPlan = []
                
                XCTAssertNotNil(playerCopy.map.tile(at: position).city)
                
                if let city = playerCopy.getCity(at: position) {
//                    city.addAvailable(action: CreateSettlerAction(game: game,
//                                                                  player: playerCopy,
//                                                                  city: city))
                    city.addAvailable(action: CreateInfantry1Action(game: game,
                                                                    player: playerCopy,
                                                                    city: city))
                    city.addAvailable(action: BuildBarracksAction(game: game,
                                                                  player: playerCopy,
                                                                  city: city))
                    city.addAvailable(action: BuildProductionAction(game: game,
                                                                    player: playerCopy,
                                                                    city: city))
                    
                    for action1 in city.getAvailableActions() {
                        action1.execute()
                        
                        for action2 in city.getAvailableActions() {
                            action2.execute()
                            
                            for action3 in city.getAvailableActions() {
                                action3.execute()
                                
                                for action4 in city.getAvailableActions() {
                                    action4.execute()
                                    
                                    actionPlan = [action1, action2, action3, action4]
                                    
                                    let defense = playerCopy.defense(against: enemyUnit)
                                    
                                    if defense > maxDefense {
                                        maxDefense = defense
                                        cityPosition = Position(row: row, col: col)
                                        
                                        
                                    }
                                    
                                    let terrain = game.map.tile(at: position).terrain.name
                                    var msg = "Evalutated \(position), defense: \(defense)"
                                    msg += ", \(terrain): "
                                    for action in actionPlan {
                                        msg += "\(action.name), "
                                    }
                                    print(msg)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        print("--------------------------------------------------------------------------------")
        print("Position: \(cityPosition)")
        var msg = "City defense: \(maxDefense), "
        for action in actionPlan {
            msg += "\(action.name), "
        }
        print(msg)
        print("--------------------------------------------------------------------------------")
        
        //        player.add(city: City(player: player,
        //                              theme: theme,
        //                              name: "Chicago",
        //                              assetName: "city-1",
        //                              position: Position(row: 0, col: 0)))
        //        player.addAvailable(researchAction: ResearchPotteryAction(game: game, player: player))
        //        player.addAvailable(researchAction: ResearchAlphabetAction(game: game, player: player))
        //        player.addAvailable(researchAction: ResearchWarriorCodeAction(game: game, player: player))
        //        player.addAvailable(researchAction: ResearchHorsebackRidingAction(game: game, player: player))
        //        player.addAvailable(researchAction: ResearchBronzeWorkingAction(game: game, player: player))
        //        player.addAvailable(researchAction: ResearchMasonryAction(game: game, player: player))
        //        player.addAvailable(researchAction: ResearchCeremonialBurialAction(game: game, player: player))
        //        player.cities[0].addAvailable(action: CreateSettlerAction(game: game, player: player, city: player.cities[0]))
        //        player.cities[0].addAvailable(action: BuildBarracksAction(game: game, player: player, city: player.cities[0]))
        //        player.cities[0].addAvailable(action: CreateInfantry1Action(game: game, player: player, city: player.cities[0]))
        //
        //        var depth = 0
        //        var numActionsExecuted = 0
        //
        //
        //        var plan = Plan(cities: player.cities)
        //
        //        let startState = player.clone()
        //        var maxScore = 0.0
        //
        //        while player.defense < 100 || numActionsExecuted < 500 {
        //            var msg = ""
        //
        //            if let action = player.getAvailableActions().first {
        //                plan.research.append(action)
        //                action.execute()
        //                msg += "\(action.name), #turns: \(action.numTurns), defense is now \(player.defense)\n"
        //
        //                numActionsExecuted += 1
        //            }
        //            else {
        //                break
        //            }
        //
        //            for action in player.cities[0].getAvailableActions() {
        //                action.execute()
        //                msg += "\(action.name), #turns: \(action.numTurns), defense is now \(player.defense)\n"
        //            }
        //
        //            let diff = startState.diff(other: player)
        //            msg += "{\"attack\": \(diff.attack), \"defense\": \(diff.defense), \"groundDefense\": \(diff.defenseAgainstGroundAttacks)}\n"
        //
        //            if IncreaseDefenseInsistence.getScore(diff: diff) > maxScore {
        //                maxScore = IncreaseDefenseInsistence.getScore(diff: diff)
        //                msg += "New max score: \(maxScore)  -----------------------------------------------------------------------\n"
        //                print(msg)
        //            }
        //
        //        }
        //
        //
        //
        //        let workingCopy = player.clone()
        //
        //        let settler = Settler(game: game,
        //                              player: workingCopy,
        //                              theme: theme,
        //                              name: "Settler",
        //                              position: Position(row: 1, col: 1))
        //        workingCopy.add(cityBuilder: settler)
        //
        //        XCTAssertEqual(player.cities.count, 0)
        //        XCTAssertEqual(workingCopy.cities.count, 0)
        //        buildCityAction.execute()
        //
        ////        let city = City(player: workingCopy,
        ////                        theme: game.theme,
        ////                        name: "New City",
        ////                        assetName: "city-1",
        ////                        position: Position(row: 1, col: 1))
        ////        workingCopy.add(city: city)
        //        XCTAssertEqual(player.cities.count, 0)
        //        XCTAssertEqual(workingCopy.cities.count, 1)
        
        //        let moveCommand = MoveUnitCommand(commandId: -1,
        //                                          game: game,
        //                                          turn: turn1,
        //                                          player: player,
        //                                          type: moveUnitType,
        //                                          ordinal: 2,
        //                                          unit: settler,
        //                                          to: Position(row: 0, col: 1))
        //        moveCommand.execute(
    }
    
}
