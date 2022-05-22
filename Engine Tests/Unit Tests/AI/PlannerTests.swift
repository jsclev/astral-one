import XCTest
import Engine

class PlannerTests: XCTestCase {

    func testGetActions1() throws {
        let theme = Theme(id: 1, name: "Test Theme")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        let startState = Player(playerId: 1, game: game)
        let player = startState.clone()
        
        // Execute the sequence of actions that the planner constructed
        for action in player.getAvailableActions() {
            action.execute()
        }
        
        // We purposefully did not add any available actions, so the planner cannot do anything
        XCTAssertEqual(player.defense, startState.defense)

    }
    
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
//            print("New action sequence:")
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
    
    func testGetActions99() throws {
        let theme = Theme(id: 1, name: "test theme")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game)
        let city = City(player: player,
                        theme: theme,
                        name: "test city",
                        assetName: "city",
                        position: Position(row: 0, col: 0))
        // let ai = RandomAI(game: game, player: player)
        
        // let createUnitType = CommandType(id: 1, name: "Create Unit")
        // let moveUnitType = CommandType(id: 1, name: "Move Unit")
        
        // let turn1 = Turn(id: 1, year: -4000, ordinal: 1, displayText: "4000 BC")
        
        player.add(city: city)
        player.addAvailable(researchAction: ResearchPotteryAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchAlphabetAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchWarriorCodeAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchHorsebackRidingAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchBronzeWorkingAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchMasonryAction(game: game, player: player))
        player.addAvailable(researchAction: ResearchCeremonialBurialAction(game: game, player: player))
//        city.addAvailable(action: CreateSettlerCommand(commandId: 1,
//                                                       game: game,
//                                                       turn: turn1,
//                                                       player: player,
//                                                       type: createUnitType,
//                                                       ordinal: 0,
//                                                       city: city))
//        city.addAvailable(action: BuildBarracksCommand())
//        city.addAvailable(action: CreateInfantry1Action())
        
        let workingCopy = player.clone()
        let workingCity = workingCopy.cities[0]
        let cityActions = Array(workingCity.getAvailableActions())

        Array(workingCopy.getAvailableActions())[0].execute()
        cityActions[0].execute()
        cityActions[1].execute()

        XCTAssertFalse(city.has(building: BuildingType.Barracks))
        XCTAssertEqual(player.units.count, 0)

        XCTAssertTrue(workingCity.has(building: BuildingType.Barracks))
        XCTAssertEqual(workingCopy.units.count, 1)

    }
    
    func testGetActions98() throws {
        let theme = Theme(id: 1, name: "Standard")
        let map = Map(mapId: 1, width: 3, height: 3)
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game)
        let player2 = Player(playerId: 2, game: game)
        // let turn1 = Turn(id: 1, year: -4000, ordinal: 1, displayText: "4000 BC")
        // let createUnitType = CommandType(id: 1, name: "Create Unit")
        // let moveUnitType = CommandType(id: 1, name: "Move Unit")
        
        try map.add(tile: Tile(id: 1,
                               position: Position(row: 0, col: 0),
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Grass",
                                                type: TerrainType.Grassland,
                                                food: 2.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 1.0,
                                                defenseBonus: 1.0)))
        try map.add(tile: Tile(id: 1,
                               position: Position(row: 0, col: 1),
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Forest",
                                                type: TerrainType.Forest,
                                                food: 1.0,
                                                shields: 2.0,
                                                trade: 0.0,
                                                movementCost: 2.0,
                                                defenseBonus: 1.5)))
        try map.add(tile: Tile(id: 1,
                               position: Position(row: 0, col: 2),
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Hills",
                                                type: TerrainType.Hills,
                                                food: 1.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 2.0,
                                                defenseBonus: 2.0)))
        try map.add(tile: Tile(id: 1,
                               position: Position(row: 1, col: 0),
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Mountain",
                                                type: TerrainType.Mountains,
                                                food: 0.0,
                                                shields: 1.0,
                                                trade: 0.0,
                                                movementCost: 3.0,
                                                defenseBonus: 3.0)))
        try map.add(tile: Tile(id: 1,
                               position: Position(row: 1, col: 1),
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Jungle",
                                                type: TerrainType.Jungle,
                                                food: 1.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 2.0,
                                                defenseBonus: 1.5)))
        try map.add(tile: Tile(id: 1,
                               position: Position(row: 1, col: 2),
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Swamp",
                                                type: TerrainType.Swamp,
                                                food: 1.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 2.0,
                                                defenseBonus: 1.5)))
        try map.add(tile: Tile(id: 1,
                               position: Position(row: 2, col: 0),
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Desert",
                                                type: TerrainType.Desert,
                                                food: 0.0,
                                                shields: 1.0,
                                                trade: 0.0,
                                                movementCost: 1.0,
                                                defenseBonus: 1.0)))
        try map.add(tile: Tile(id: 1,
                               position: Position(row: 2, col: 1),
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Plains",
                                                type: TerrainType.Plains,
                                                food: 1.0,
                                                shields: 1.0,
                                                trade: 0.0,
                                                movementCost: 1.0,
                                                defenseBonus: 1.0)))
        try map.add(tile: Tile(id: 1,
                               position: Position(row: 2, col: 2),
                               terrain: Terrain(id: 1,
                                                tiledId: 1,
                                                name: "Tundra",
                                                type: TerrainType.Tundra,
                                                food: 1.0,
                                                shields: 0.0,
                                                trade: 0.0,
                                                movementCost: 1.0,
                                                defenseBonus: 1.0)))
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
                let playerCopy = player.clone()
                let position = Position(row: row, col: col)
                
                let settler = Settler(game: game,
                                      player: playerCopy,
                                      theme: theme,
                                      name: "Settler",
                                      position: position)
                let buildCity = BuildCityAction(game: game,
                                                player: playerCopy,
                                                cityBuilder: settler)
                buildCity.execute()
                actionPlan = []
                
                if let city = playerCopy.getCity(at: position) {
                    city.addAvailable(action: CreateSettlerAction(game: game,
                                                                  player: playerCopy,
                                                                  city: city))
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
//        let buildCityAction = BuildCityAction(game: game,
//                                              player: workingCopy,
//                                              cityBuilder: settler)
//
//        XCTAssertEqual(buildCityAction.cost, 0)
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
