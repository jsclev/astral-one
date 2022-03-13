import SpriteKit
import GameplayKit

class DamageableComponent: GKComponent {
    var hp: Int = 0
    var currentHp: Int = 0
    
    init(hp: Int, currentHp: Int) {
        self.hp = hp
        self.currentHp = currentHp
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
    }
    override func willRemoveFromEntity() {
    }
    override func update(deltaTime seconds: TimeInterval) {
    }
    override class var supportsSecureCoding: Bool {
        true
    }
}
