import Foundation
import SpriteKit

public class Founder: SKSpriteNode {
    private var walkTextures: [SKTexture]?
    private var unselectedWalkTextures: [SKTexture]?
    private var selectedWalkTextures: [SKTexture]?
    private var isSpriteSelected = false
    
    public init() {
        let texture = SKTexture(imageNamed: "builder1")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        walkTextures = loadTextures(atlas: "builder",
                                    prefix: "builder",
                                    startsAt: 1,
                                    stopsAt: 16)
        unselectedWalkTextures = loadTextures(atlas: "builder",
                                              prefix: "builder",
                                              startsAt: 1,
                                              stopsAt: 16)
        selectedWalkTextures = loadTextures(atlas: "builder_selected",
                                            prefix: "builder_selected",
                                            startsAt: 1,
                                            stopsAt: 16)
        walkTextures = unselectedWalkTextures
        name = "builder"
        setScale(1.0)
        anchorPoint = CGPoint(x: 0.5, y: 0.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func walk() {
        // Check for textures
        guard let walkTextures = walkTextures else {
            preconditionFailure("Could not find textures!")
        }
        
        var animationName = "builder"
        if isSelected() {
            animationName = "builder_selected"
        }
        
        // Run animation (forever)
        startAnimation(textures: walkTextures, speed: 0.06,
                       name: animationName,
                       count: 0, resize: true, restore: true)
    }
    
    public func toggleSelected() {
        isSpriteSelected = !isSpriteSelected
        
        if isSpriteSelected {
            walkTextures = selectedWalkTextures
        }
        else {
            walkTextures = unselectedWalkTextures
        }
        
        walk()
    }
    
    public func isSelected() -> Bool {
        return isSpriteSelected
    }
    
    public func moveToPosition(pos: CGPoint, speed: TimeInterval) {
        let moveAction = SKAction.move(to: pos,
                                       duration: speed)
        run(moveAction, completion: {
            self.removeAllActions()
        })
    }
}
