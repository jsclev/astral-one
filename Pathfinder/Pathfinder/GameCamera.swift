import SpriteKit
import SwiftUI
import Astral_One_Engine

class GameCamera: SKCameraNode {
    let entityManager: EntityManager
    
    init(_ entityManager: EntityManager) {
        self.entityManager = entityManager
        
        super.init()
        name = "camera"
        print("Camera size: \(self.calculateAccumulatedFrame().size)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        print("Camera size: \(self.calculateAccumulatedFrame().size)")
        
        if let scene = self.scene {
            print("Camera size: \(self.calculateAccumulatedFrame().size)")
        }
        
    }
}
