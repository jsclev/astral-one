import Foundation

public class ActionSequence {
    private let goalScorer: GoalScorer
    private var actions0: [Action] = []
    private var actions1: [Action] = []
    private var actions2: [Action] = []
    
    private var size: Int {
        var maxLength = 0
        
        if actions0.count > maxLength {
            maxLength = actions0.count
        }
        
        if actions1.count > maxLength {
            maxLength = actions1.count
        }
        
        if actions2.count > maxLength {
            maxLength = actions2.count
        }
        
        return maxLength
    }
    
    public init(goalScorer: GoalScorer) {
        self.goalScorer = goalScorer
    }
    
    public func add(action: Action) {
        actions0.append(action)
    }
    
    public func add(action: Action, layer: Int) {
        if layer == 1 {
            actions1.append(action)
        }
        else if layer == 2 {
            actions2.append(action)
        }
    }
    
    public var productionCost: Int {
        var sum = 0

        for i in 0..<size {
            if i < actions0.count {
                sum += actions0[i].cost
            }
            
            if i < actions1.count {
                sum += actions1[i].cost
            }
            
            if i < actions2.count {
                sum += actions2[i].cost
            }
        }
        
        return sum
    }
    
    public var advanceCost: Int {
        var sum = 0
        
        for i in 0..<size {
            if i < actions0.count {
                sum += actions0[i].scienceCost
            }
            
            if i < actions1.count {
                sum += actions1[i].scienceCost
            }
            
            if i < actions2.count {
                sum += actions2[i].scienceCost
            }
        }
        
        return sum
    }
    
    public func execute(game: Game, player: Player) -> Double {
        let startState = player.clone()
        
        for i in 0..<size {
            if i < actions0.count {
                actions0[i].execute()
            }
            
            if i < actions1.count {
                actions1[i].execute()
            }
            
            if i < actions2.count {
                actions2[i].execute()
            }
        }
        
        return goalScorer.getScore(game: game,
                                   start: startState,
                                   end: player,
                                   cost: productionCost)

    }
}
