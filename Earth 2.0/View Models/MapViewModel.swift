import Foundation
import SpriteKit
import SwiftUI

class MapViewModel {
    let texture0: SKTexture
    let texture1: SKTexture
    let texture2: SKTexture
    let texture3: SKTexture
    var mapSize: CGSize
    let cameraSize: CGSize
    var startCameraPosition: CGPoint
    var cameraPosition: CGPoint
    
    init() {
        texture0 = SKTexture(imageNamed: "background10")
        texture1 = SKTexture(imageNamed: "background11")
        texture2 = SKTexture(imageNamed: "background12")
        texture3 = SKTexture(imageNamed: "background13")

        mapSize = texture3.size()
        cameraSize = CGSize(width: UIScreen.main.bounds.size.width,
                            height: UIScreen.main.bounds.size.height)
        
        // Start the initial camera position in the middle of the map
        cameraPosition = CGPoint(x: (cameraSize.width / 2) + (mapSize.width - cameraSize.width) / 2,
                                 y: (cameraSize.height / 2) + (mapSize.height - cameraSize.height) / 2)
        startCameraPosition = CGPoint(x: cameraPosition.x,
                                      y: cameraPosition.y)

        log()
    }
    
    func changeMap(mapName: String) {
        if (mapName == "zero") {
            mapSize = texture0.size()
        }
        else if (mapName == "one") {
            mapSize = texture1.size()
        }
        else if (mapName == "two") {
            mapSize = texture2.size()
        }
        else {
            mapSize = texture3.size()
        }
        
        // Start the initial camera position in the middle of the map
        cameraPosition = CGPoint(x: (cameraSize.width / 2) + (mapSize.width - cameraSize.width) / 2,
                                 y: (cameraSize.height / 2) + (mapSize.height - cameraSize.height) / 2)
        startCameraPosition = CGPoint(x: cameraPosition.x,
                                      y: cameraPosition.y)
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
