import SpriteKit
import GameplayKit

public class SpriteComponent: GKComponent {
    public let node: SKSpriteNode
    
    public init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
