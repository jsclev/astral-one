import Foundation
import SpriteKit
import GameplayKit

public class EntityManager {
    var entities = Set<GKEntity>()
    let scene: SKScene
    
    public init(scene: SKScene) {
        self.scene = scene
    }
    
    public func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
    }
    
    public func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
    }
}
