import Foundation

public class IncreaseDefenseGoalScorer: GoalScorer {
    public override init() {
        super.init()
    }
    
    public override func getScore(game: Game, start: Player, end: Player, cost: Int) -> Double {
        if cost == 0 {
            return ((Double(end.defense - start.defense) / Double(start.defense)) * 100.0) / Double(0.001)
        }
        else {
            return ((Double(end.defense - start.defense) / Double(start.defense)) * 100.0) / Double(cost)
        }
    }
}
