import Foundation

public class Warrior: Unit {
    public init(playerId: Int, row: Int, col: Int) {
        super.init(playerId: playerId,
                   name: "Warrior",
                   maxHP: 10,
                   row: row,
                   col: col)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
