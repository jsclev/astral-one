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
        var defenseDiff: Double = 0.0
        var results: [DefenseDiff] = []
        
        for _ in 0..<100 {
            workingCopy = player.clone()
            defenseDiff = 0
            var actions: [Action] = []
            
            for _ in 0..<4 {
                if let action = workingCopy.getRandomAvailableAction() {
                    action.execute(game: game, player: workingCopy)
                    defenseDiff += workingCopy.defense - startDefense
                    actions.append(action)
                }
            }
            
            results.append(DefenseDiff(value: defenseDiff, actions: actions))
        }
        
        results.sort {(lhs, rhs) in return lhs.value < rhs.value}
        
//        for diff in results {
//            print("Defense diff: \(diff.value)")
//        }
        
        if results.count > 0 {
            let index = Int(player.playStyle.defense * 100) - 1
            
            return results[index].actions
        }
        
        return []
    }
}
