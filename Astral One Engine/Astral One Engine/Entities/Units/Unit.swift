import Foundation
import GameplayKit

public class Unit: GKEntity {
    let name: String
    let maxHP: Int
    
    init(name: String, maxHP: Int) {
        self.name = name
        self.maxHP = maxHP
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
