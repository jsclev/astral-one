import Foundation

fileprivate struct DefenseDiff {
    fileprivate let value: Double
    fileprivate let actions: [Action]
    
    init(value: Double, actions: [Action]) {
        self.value = value
        self.actions = actions
    }
}

public class RandomAI {
    private let game: Game
    private let player: Player
    
    public init(game: Game, player: Player) {
        self.game = game
        self.player = player
    }
    
    public func nextActionSequence() -> [Action] {
        var workingCopy = player.clone()
        let startDefense = player.defense
        var diff: Double = 0.0
        var randomNum: Int = 0
        var results: [DefenseDiff] = []
        
        for _ in 0..<100 {
            workingCopy = player.clone()
            diff = 0.0
            var actions: [Action] = []
            
            let playerActions = Array(workingCopy.getAvailableActions())
            randomNum = Int.random(in: 0..<playerActions.count)
            let randomPlayerAction = playerActions[randomNum]
            randomPlayerAction.execute()
            actions.append(randomPlayerAction)
            
            for city in workingCopy.map.cities {
                let availableCityActions = Array(city.getAvailableActions())
                randomNum = Int.random(in: 0..<availableCityActions.count)
                let randomCityAction = availableCityActions[randomNum]
                randomCityAction.execute()
                
                actions.append(randomCityAction)
            }
            
            diff += workingCopy.defense - startDefense
            
            results.append(DefenseDiff(value: diff, actions: actions))
        }
        
        results.sort {(lhs, rhs) in return lhs.value < rhs.value}
        
        if results.count > 0 {
            let index = Int(player.strategy.defense * 100) - 1
            
            return results[index].actions
        }
        
        return []
    }
}
