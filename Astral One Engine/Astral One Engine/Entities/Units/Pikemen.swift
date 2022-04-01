import Foundation

public class Pikemen: Unit {
    init() {
        super.init(name: "Pikemen",
        maxHP: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
