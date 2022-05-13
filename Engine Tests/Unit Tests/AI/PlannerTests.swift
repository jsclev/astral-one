import XCTest
import Engine

class PlannerTests: XCTestCase {

    func testGetActions1() throws {
        // let planner = Planner()
        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
        let startState = Player(playerId: 1)
        let player = startState.clone()
        
        // let actions = planner.getAction(game: game, player: player, startActions: player.availableActions)
        
        // Execute the sequence of actions that the planner constructed
        for action in player.getAvailableActions() {
            action.execute(game: game, player: player)
        }
        
        // We purposefully did not add any available actions, so the planner cannot do anything
        XCTAssertEqual(player.defense, startState.defense)

    }
    
    func testGetActions2() throws {
        // let planner = Planner()
        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
        let player = Player(playerId: 1)
        let playerCopy = player.clone()

        
        player.addAvailable(action: CreateInfantry1Action())
        // let actions = planner.getAction(game: game, player: playerCopy, startActions: player.availableActions)
        
        for action in player.getAvailableActions() {
            action.execute(game: game, player: playerCopy)
        }
        
        XCTAssertEqual(player.defense, 0.001)
        XCTAssertEqual(playerCopy.defense, 1)

    }
    
    func testGetActions3() throws {
        // let planner = Planner()
        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
        let player = Player(playerId: 1)
        
        player.addAvailable(action: CreateInfantry1Action())
        player.addAvailable(action: ResearchBronzeWorkingAction())
        
        let action1 = CreateInfantry1Action()
        let playerClone1 = player.clone()
        action1.execute(game: game, player: playerClone1)
        let goalScorer1 = IncreaseDefenseGoalScorer()
        
        XCTAssertGreaterThan(goalScorer1.getScore(game: game, start: player, end: playerClone1, cost: 1), 0)
    }
    
    func testGetActions4() throws {
        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
        let startState = Player(playerId: 1)
        let player = startState.clone()
        
        let actionSequence: [Action] = [
            ResearchBronzeWorkingAction(),
            CreateInfantry2Action()
        ]
        
        for action in actionSequence {
            action.execute(game: game, player: player)
        }
        
        let goalScorer = IncreaseDefenseGoalScorer()
        let score = goalScorer.getScore(game: game, start: startState, end: player, cost: 1)
        
        XCTAssertGreaterThan(score, 1000.0)
    }
    
    func testGetActions5() throws {
        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
        let goalScorer = IncreaseDefenseGoalScorer()
        let startState = Player(playerId: 1)
        
        let player1 = startState.clone()
        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
        actionSequence1.add(action: ResearchBronzeWorkingAction())
        actionSequence1.add(action: CreateInfantry2Action())
        let score1 = actionSequence1.execute(game: game, player: player1)
        
        let player2 = startState.clone()
        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
        actionSequence2.add(action: ResearchHorsebackRidingAction())
        actionSequence2.add(action: CreateCavalry1Action())
        let score2 = actionSequence2.execute(game: game, player: player2)
        
        XCTAssertGreaterThan(score1, 0)
        XCTAssertGreaterThan(score2, 0)
        XCTAssertGreaterThan(score1, score2)
    }
    
    func testGetActions6() throws {
        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
        let goalScorer = IncreaseDefenseGoalScorer()
        let startState = Player(playerId: 1)
        
        let player1 = startState.clone()
        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
        actionSequence1.add(action: ResearchBronzeWorkingAction())
        actionSequence1.add(action: CreateInfantry2Action())
        let score1 = actionSequence1.execute(game: game, player: player1)
        
        let player2 = startState.clone()
        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
        actionSequence2.add(action: ResearchHorsebackRidingAction())
        actionSequence2.add(action: CreateCavalry1Action())
        let score2 = actionSequence2.execute(game: game, player: player2)

        XCTAssertGreaterThan(score1, 0)
        XCTAssertGreaterThan(score2, 0)
        XCTAssertGreaterThan(score1, score2)
    }
    
    func testGetActions7() throws {
        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
        let goalScorer = IncreaseDefenseGoalScorer()
        let startState = Player(playerId: 1)
        
        let player1 = startState.clone()
        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
        actionSequence1.add(action: ResearchBronzeWorkingAction())
        actionSequence1.add(action: CreateInfantry2Action())
        let score1 = actionSequence1.execute(game: game, player: player1)
        
        let player2 = startState.clone()
        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
        actionSequence2.add(action: ResearchWarriorCodeAction())
        actionSequence2.add(action: CreateInfantry3Action())
        let score2 = actionSequence2.execute(game: game, player: player2)
        
        XCTAssertGreaterThan(score1, 0)
        XCTAssertGreaterThan(score2, 0)
        XCTAssertGreaterThan(score1, score2)
    }
    
    func testGetActions8() throws {
        let theme = Theme(id: 1, name: "Test Theme")
        let game = Game(theme: theme)
        let goalScorer = IncreaseDefenseGoalScorer()
        let startState = Player(playerId: 1)
        
        let player1 = startState.clone()
        player1.add(city: City(theme: theme,
                               player: player1,
                               name: "Test City 1",
                               assetName: "",
                               position: Position(row: 0, col: 0)))
        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
        actionSequence1.add(action: BuildBarracksAction())
        actionSequence1.add(action: CreateInfantry2Action())
        let score1 = actionSequence1.execute(game: game, player: player1)
        
        let player2 = startState.clone()
        player2.add(city: City(theme: theme,
                               player: player2,
                               name: "Test City 2",
                               assetName: "",
                               position: Position(row: 0, col: 1)))
        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
        actionSequence2.add(action: BuildBarracksAction())
        actionSequence2.add(action: CreateCavalry1Action())
        let score2 = actionSequence2.execute(game: game, player: player2)
        
        XCTAssertGreaterThan(score1, 0)
        XCTAssertGreaterThan(score2, 0)
        XCTAssertGreaterThan(score1, score2)
    }
    
    func testGetActions9() throws {
        let theme = Theme(id: 1, name: "Test Theme")
        let game = Game(theme: theme)
        let goalScorer = IncreaseDefenseGoalScorer()
        let startState = Player(playerId: 1)
        
        let player1 = startState.clone()
        player1.add(city: City(theme: theme,
                               player: player1,
                               name: "Test City 1",
                               assetName: "",
                               position: Position(row: 0, col: 0)))
        let actionSequence1 = ActionSequence(goalScorer: goalScorer)
        actionSequence1.add(action: CreateInfantry1Action())
        let score1 = actionSequence1.execute(game: game, player: player1)
        
        let player2 = startState.clone()
        player2.add(city: City(theme: theme,
                               player: player2,
                               name: "Test City 2",
                               assetName: "",
                               position: Position(row: 0, col: 1)))
        let actionSequence2 = ActionSequence(goalScorer: goalScorer)
        actionSequence2.add(action: CreateInfantry1Action())
        actionSequence2.add(action: BuildWallsAction())
        let score2 = actionSequence2.execute(game: game, player: player2)
        
        XCTAssertGreaterThan(score1, 0)
        XCTAssertGreaterThan(score2, 0)
        XCTAssertGreaterThan(score1, score2)
    }
    
    func testGetActions10() throws {
        let theme = Theme(id: 1, name: "Test Theme")
        let game = Game(theme: theme)
        // let goalScorer = IncreaseDefenseGoalScorer()
        let player = Player(playerId: 1)
        let ai = RandomAI(player: player)
        
        player.addAvailable(action: BuildBarracksAction())
        player.addAvailable(action: CreateInfantry1Action())
        player.addAvailable(action: ResearchPotteryAction())
        player.addAvailable(action: ResearchAlphabetAction())
        player.addAvailable(action: ResearchWarriorCodeAction())
        player.addAvailable(action: ResearchHorsebackRidingAction())
        player.addAvailable(action: ResearchBronzeWorkingAction())
        player.addAvailable(action: ResearchMasonryAction())
        player.addAvailable(action: ResearchCeremonialBurialAction())

        while player.defense < 100 {
            let action = ai.nextAction()
            action.execute(game: game, player: player)
            print("\(action.name) executed, player defense is now \(player.defense).")
        }
    }
    
    func testGetActions11() throws {
        let game = Game(theme: Theme(id: 1, name: "Test Theme"))
        let player = Player(playerId: 1)
        let ai = RandomAI(player: player)
        
        player.addAvailable(action: ResearchWarriorCodeAction())
        
        var action = ai.nextAction()
        XCTAssertEqual(action, ResearchWarriorCodeAction())
        action.execute(game: game, player: player)
        
        action = ai.nextAction()
        XCTAssertEqual(action, ResearchFeudalismAction())
        action.execute(game: game, player: player)
        
        action = ai.nextAction()
        XCTAssertEqual(action, ResearchChivalryAction())
        action.execute(game: game, player: player)
        
        action = ai.nextAction()
        XCTAssertEqual(action, ResearchLeadershipAction())
        action.execute(game: game, player: player)
    }

}
