import Foundation

public class Warrior: Unit {
    init() {
        super.init(name: "Warrior",
                   maxHP: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
