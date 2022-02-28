import Foundation
import SwiftUI
import SpriteKit

class MapViewModel {
//    let cameraSize: CGSize {
//        CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//        UIScreen.main.bounds.width
//    }
//
//    var height: CGFloat {
//        UIScreen.main.bounds.height
//    }
    
    var cameraPosition = CGPoint(x: 0.0, y: 0.0)
    
    let texture = SKTexture(imageNamed: "map1")
    
    init() {
        let mapSize = texture.size()
        let screenSize = UIScreen.main.bounds
        
        cameraPosition = CGPoint(x: (mapSize.width / 2) - (screenSize.width / 2),
                                 y: (mapSize.height / 2) - (screenSize.height / 2))
    }
    
    func setCameraPosition(_ position: CGPoint) {
        self.cameraPosition.x = -position.x
        self.cameraPosition.y = position.y
    }
}
