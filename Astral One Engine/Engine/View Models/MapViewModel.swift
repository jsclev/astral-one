import Foundation
import SpriteKit
import SwiftUI

public class MapViewModel {
    public var mapSize: CGSize
    public let cameraSize: CGSize
    public var startCameraPosition: CGPoint
    public var cameraPosition: CGPoint
    public var scale = 1.0
    
    public init() {
        cameraSize = CGSize(width: UIScreen.main.bounds.size.width,
                            height: UIScreen.main.bounds.size.height)
        mapSize = CGSize(width: Constants.mapWidth,
                         height: Constants.mapHeight)
        
        // Start the initial camera position in the middle of the map
        cameraPosition = CGPoint(x: (mapSize.width - cameraSize.width) / 2,
                                 y: (mapSize.height - cameraSize.height) / 2)
        startCameraPosition = CGPoint(x: cameraPosition.x,
                                      y: cameraPosition.y)
//                cameraPosition = CGPoint(x: 0.0,
//                                         y: 0.0)
//                startCameraPosition = CGPoint(x: cameraPosition.x,
//                                              y: cameraPosition.y)
    }
    
    public func updateScale(newScale: Double) {
//        scale = 1.0 + (1/newScale - 1)
//
//        if scale >= 3.35 {
//            scale = 3.35
//        }
//
        print(scale)
    }
    
    public func changeMap(mapName: String) {
        // Start the initial camera position in the middle of the map
        cameraPosition = CGPoint(x: (cameraSize.width / 2) + (mapSize.width - cameraSize.width) / 2,
                                 y: (cameraSize.height / 2) + (mapSize.height - cameraSize.height) / 2)
        startCameraPosition = CGPoint(x: cameraPosition.x,
                                      y: cameraPosition.y)
    }
    
    public func moveCamera(translation: CGSize) {
        cameraPosition.x = startCameraPosition.x - translation.width
        cameraPosition.y = startCameraPosition.y + translation.height
        
        print("[\(cameraPosition.x),\(cameraPosition.y),\(scale)]")
        
        let xThreshold = 2150.0
        let yTheshold = 1150.0
        
        if scale * cameraPosition.x < -xThreshold {
            cameraPosition.x = -xThreshold
        }
        else if scale * cameraPosition.x > xThreshold {
            cameraPosition.x = xThreshold
        }
        
        if scale * cameraPosition.y > yTheshold {
            cameraPosition.y = yTheshold
        }
        else if scale * cameraPosition.y < -yTheshold {
            cameraPosition.y = -yTheshold
        }
        
        //        if (startCameraPosition.x - translation.width <= (mapSize.width / 2) - (mapSize.width - cameraSize.width) / 2) {
        //            cameraPosition.x = (mapSize.width / 2) - (mapSize.width - cameraSize.width) / 2
        //        }
        //        else if (startCameraPosition.x - translation.width >= (mapSize.width / 2) + (mapSize.width - cameraSize.width) / 2) {
        //
        //            cameraPosition.x = (mapSize.width / 2) - (mapSize.width - cameraSize.width) / 2
        //            cameraPosition.x = (mapSize.width / 2) + (mapSize.width - cameraSize.width) / 2
        //        } else {
        //            cameraPosition.x = startCameraPosition.x - translation.width
        //        }
        
        //        if (startCameraPosition.y + translation.height >= (mapSize.height / 2) + (mapSize.height - cameraSize.height) / 2) {
        //            cameraPosition.y = (mapSize.height / 2) + (mapSize.height - cameraSize.height) / 2
        //        }
        //        else if (startCameraPosition.y + translation.height <= cameraSize.height / 2) {
        //            cameraPosition.y = cameraSize.height / 2
        //        }
        //        else {
        //            cameraPosition.y = startCameraPosition.y + translation.height
        //        }
    }
    
    public func log() {
        print("Total map size is [\(mapSize.width), \(mapSize.height)]")
        print("Camera size is [\(cameraSize.width), \(cameraSize.height)]")
        print("Camera position is [\(cameraPosition.x), \(cameraPosition.y)]")
        print("Start camera position is [\(startCameraPosition.x), \(startCameraPosition.y)]")
        print("----------------------------------------------------------------")
    }
    
    public func resetCamera() {
        startCameraPosition.x = cameraPosition.x
        startCameraPosition.y = cameraPosition.y
    }
}
