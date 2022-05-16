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
            action.execute(game: game, player: player)
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
    
    func testGetActions8() throws {
        let theme = Theme(id: 1, name: "Test Theme")
        let map = Map(mapId: 1, width: 2, height: 2)
        let game = Game(theme: theme, map: map)
        let goalScorer = IncreaseDefenseGoalScorer()
        let startState = Player(playerId: 1, game: game)
        
        let player1 = startState.clone()
        let city1 = City(player: player1,
                         theme: theme,
                         name: "Test City 1",
                         assetName: "",
                         position: Position(row: 0, col: 0))
        player1.add(city: city1)
        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
        actionSequence1.add(action: BuildBarracksAction())
        actionSequence1.add(action: CreateInfantry2Action(city: city1))
        let score1 = actionSequence1.execute(game: game, player: player1)
        
        let player2 = startState.clone()
        let city2 = City(player: player2,
                         theme: theme,
                         name: "Test City 2",
                         assetName: "",
                         position: Position(row: 0, col: 1))
        player2.add(city: city2)
        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
        actionSequence2.add(action: BuildBarracksAction())
        actionSequence2.add(action: CreateCavalry1Action(city: city2))
        let score2 = actionSequence2.execute(game: game, player: player2)
        
        XCTAssertGreaterThan(score1, 0)
        XCTAssertGreaterThan(score2, 0)
        XCTAssertGreaterThan(score1, score2)
    }
    
    func testGetActions9() throws {
        let theme = Theme(id: 1, name: "Test Theme")
        let map = Map(mapId: 1, width: 2, height: 2)
        let game = Game(theme: theme, map: map)
        let goalScorer = IncreaseDefenseGoalScorer()
        let startState = Player(playerId: 1, game: game)
        
        let player1 = startState.clone()
        player1.add(city: City(player: player1,
                               theme: theme,
                               name: "Test City 1",
                               assetName: "",
                               position: Position(row: 0, col: 0)))
        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
        actionSequence1.add(action: CreateInfantry1Action())
        let score1 = actionSequence1.execute(game: game, player: player1)
        
        let player2 = startState.clone()
        player2.add(city: City(player: player2,
                               theme: theme,
                               name: "Test City 2",
                               assetName: "",
                               position: Position(row: 0, col: 1)))
        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
        actionSequence2.add(action: CreateInfantry1Action())
        actionSequence2.add(action: BuildCityWallsAction(city: player2.cities[0]))
        let score2 = actionSequence2.execute(game: game, player: player2)
        
        XCTAssertGreaterThan(score1, 0)
        XCTAssertGreaterThan(score2, 0)
        XCTAssertGreaterThan(score1, score2)
    }
    
    func testGetActions10() throws {
        let theme = Theme(id: 1, name: "test theme")
        let map = Map(mapId: 1, width: 1, height: 1)
        let game = Game(theme: theme, map: map)
        let player = Player(playerId: 1, game: game)
        let city = City(player: player,
                        theme: theme,
                        name: "test city",
                        assetName: "city",
                        position: Position(row: 0, col: 0))
        let ai = RandomAI(game: game, player: player)

        player.add(city: city)
        player.addAvailable(researchAction: ResearchPotteryAction())
//        player.addAvailable(researchAction: ResearchAlphabetAction())
//        player.addAvailable(researchAction: ResearchWarriorCodeAction())
//        player.addAvailable(researchAction: ResearchHorsebackRidingAction())
//        player.addAvailable(researchAction: ResearchBronzeWorkingAction())
//        player.addAvailable(researchAction: ResearchMasonryAction())
//        player.addAvailable(researchAction: ResearchCeremonialBurialAction())
        city.addAvailable(action: BuildBarracksAction())
        city.addAvailable(action: CreateInfantry1Action())

        while player.defense < 300 {
            print("New action sequence:")
            for action in ai.nextActionSequence() {
                action.execute(game: game, player: player)
                print("\(action.name) executed, player defense is now \(player.defense).")
            }
        }
    }
    
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
        let ai = RandomAI(game: game, player: player)
        
        player.add(city: city)
        player.addAvailable(researchAction: ResearchPotteryAction())
        player.addAvailable(researchAction: ResearchAlphabetAction())
        player.addAvailable(researchAction: ResearchWarriorCodeAction())
        player.addAvailable(researchAction: ResearchHorsebackRidingAction())
        player.addAvailable(researchAction: ResearchBronzeWorkingAction())
        player.addAvailable(researchAction: ResearchMasonryAction())
        player.addAvailable(researchAction: ResearchCeremonialBurialAction())
        city.addAvailable(action: BuildBarracksAction())
        city.addAvailable(action: CreateInfantry1Action())
        
        let workingCopy = player.clone()
        let workingCity = workingCopy.cities[0]
        let cityActions = Array(workingCity.getAvailableActions())

        Array(workingCopy.getAvailableActions())[0].execute(game: game, player: workingCopy)
        cityActions[0].execute(game: game, player: workingCopy, city: workingCity)
        cityActions[1].execute(game: game, player: workingCopy, city: workingCity)

        XCTAssertFalse(city.has(building: BuildingType.Barracks))
        XCTAssertEqual(player.units.count, 0)

        XCTAssertTrue(workingCity.has(building: BuildingType.Barracks))
        XCTAssertEqual(workingCopy.units.count, 1)

    }

}
