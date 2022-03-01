import Foundation
import SpriteKit
import SwiftUI

class MapViewModel {
    let texture: SKTexture
    let mapSize: CGSize
    let cameraSize: CGSize
    var startCameraPosition: CGPoint
    var cameraPosition: CGPoint
    var mainToolbarSize: CGSize
    
    init() {
        texture = SKTexture(imageNamed: "background6")
        mapSize = texture.size()
        
        mainToolbarSize = CGSize(width: UIScreen.main.bounds.size.width / 3,
                                 height: UIScreen.main.bounds.size.height)
        cameraSize = CGSize(width: UIScreen.main.bounds.size.width - mainToolbarSize.width,
                            height: UIScreen.main.bounds.size.height)
        
        // Start the initial camera position in the middle of the map
//        cameraPosition = CGPoint(x: (cameraSize.width / 2) + (mapSize.width - cameraSize.width) / 2 - cameraSize.width,
//                                 y: (cameraSize.height / 2) + (mapSize.height - cameraSize.height) / 2)
        
        cameraPosition = CGPoint(x: 0,
                                 y: (cameraSize.height / 2) + (mapSize.height - cameraSize.height) / 2)
        startCameraPosition = CGPoint(x: cameraPosition.x,
                                      y: cameraPosition.y)

        log()
    }
    
    func moveCamera(translation: CGSize) {
        if (startCameraPosition.x - translation.width <= (mapSize.width / 2) - (mapSize.width - cameraSize.width) / 2) {
            cameraPosition.x = (mapSize.width / 2) - (mapSize.width - cameraSize.width) / 2
        }
        else if (startCameraPosition.x - translation.width >= (mapSize.width / 2) + (mapSize.width - cameraSize.width) / 2) {
            cameraPosition.x = (mapSize.width / 2) + (mapSize.width - cameraSize.width) / 2
        } else {
            cameraPosition.x = startCameraPosition.x - translation.width
        }
        
        if (startCameraPosition.y + translation.height >= (mapSize.height / 2) + (mapSize.height - cameraSize.height) / 2) {
            cameraPosition.y = (mapSize.height / 2) + (mapSize.height - cameraSize.height) / 2
        }
        else if (startCameraPosition.y + translation.height <= cameraSize.height / 2) {
            cameraPosition.y = cameraSize.height / 2
        }
        else {
            cameraPosition.y = startCameraPosition.y + translation.height
        }
        
        log()
        print("Translation width: \(translation.width)")
        print("Translation height: \(translation.height)")

    }
    
    func log() {
        print("Total map size is [\(mapSize.width), \(mapSize.height)]")
        print("Camera size is [\(cameraSize.width), \(cameraSize.height)]")
        print("Camera position is [\(cameraPosition.x), \(cameraPosition.y)]")
        print("Start camera position is [\(startCameraPosition.x), \(startCameraPosition.y)]")
        print("----------------------------------------------------------------")
    }
    
    func resetCamera() {
        startCameraPosition.x = cameraPosition.x
        startCameraPosition.y = cameraPosition.y
    }
}
