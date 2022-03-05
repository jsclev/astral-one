import Foundation
import SpriteKit

class Builder: SKSpriteNode {
    private var walkTextures: [SKTexture]?
    
    init() {
        let texture = SKTexture(imageNamed: "builder1")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.walkTextures = self.loadTextures(atlas: "builder",
                                              prefix: "builder",
                                              startsAt: 1,
                                              stopsAt: 16)
        self.name = "builder"
        self.setScale(1.0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.0)
    }
    
    func walk() {
        // Check for textures
        guard let walkTextures = walkTextures else {
            preconditionFailure("Could not find textures!")
        }
        // Run animation (forever)
        startAnimation(textures: walkTextures, speed: 0.06,
                       name: "builder",
                       count: 0, resize: true, restore: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
