import Foundation

public class Warrior: Unit {
    init() {
        super.init(name: "Warrior")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
