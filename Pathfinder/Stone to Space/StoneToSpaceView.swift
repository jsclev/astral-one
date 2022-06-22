import Foundation
import SpriteKit
import SwiftUI
import Engine

struct StoneToSpaceView: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    @State private var startCameraPosition = CGPoint.zero
    @GestureState private var cameraPosition = CGPoint.zero
    
    @State private var location: CGPoint = .zero
    @GestureState private var fingerLocation: CGPoint? = nil

    var mapViewModel = MapViewModel()
    var scene: StoneToSpaceScene
    
    init() {
        scene = StoneToSpaceScene(mapViewModel: mapViewModel)
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                
                if !isDragging {
                    isDragging = true
                    startCameraPosition = scene.gameCamera.position
                    scene.gameCamera.removeAction(forKey: "map-pan-momentum")
                }
     
//                self.location = value.location
//                print("[offset width: \(value.width), offset height: \(offset.height)]")
//                var newLocation = startLocation ?? location
                let finalTranslationX = offset.width
                let finalTranslationY = offset.height
//                newLocation.x += finalTranslationX
//                newLocation.y += finalTranslationY
//                location = newLocation
//                mapViewModel.moveCamera(translation: CGSize(width: finalTranslationX,
//                                                            height: finalTranslationY))
//                scene.gameCamera.position = mapViewModel.cameraPosition
//                scene.gameCamera.position = CGPoint(x: -1 * self.location.x,
//                                                    y: self.location.y)
//                scene.gameCamera.position = .zero
//                print("camera width: \(scene.gameCamera.frame.width)")
//                scene.gameCamera.updatePositionLabel(pos: scene.gameCamera.position)
//                print(scene.gameCamera.position)
//                scene.gameCamera.position = CGPoint(x: scene.gameCamera.position.x - (value.translation.width * 0.05),
//                                                    y: scene.gameCamera.position.y + (value.translation.height * 0.05))
                scene.gameCamera.position = CGPoint(x: startCameraPosition.x - value.translation.width,
                                                    y: startCameraPosition.y + value.translation.height)
                
                // Get the offset between the start location and the camera's position
//                print("--------------------------------------------------------------------------")
//                print("translation: [\(value.translation.width), \(value.translation.height)]")
//                print("finger location: \(value.location)")
//                print("start location: \(value.startLocation)")
//                print("Camera position: \(scene.gameCamera.position)")
            }
            .onEnded { value in
                let temp = value.predictedEndTranslation.width - value.translation.width
                let temp2 = value.predictedEndTranslation.height - value.translation.height
                let magnitude = sqrt(
                    (temp * temp +
                     temp2 * temp2))
//                let magnitude = sqrt(
//                    (value.predictedEndTranslation.width * value.predictedEndTranslation.width +
//                     value.predictedEndTranslation.height * value.predictedEndTranslation.height))
                
                isDragging = false
//                scene.gameCamera.physicsBody?.velocity = CGVector(dx: 1, dy: 2)
                
//                print("--------------------------------------------------------------------------")
//                print("On end location: \(value.location)")
//                print("Predicted end translation: \(value.predictedEndTranslation)")
                var duration = (magnitude/2000) + 0.8
                if duration < 0.8 {
                    duration = 0.8
                }
                print("magnitude: \(magnitude)")
                print("duration: \(duration)")

                let moveAction = SKAction.move(to: CGPoint(x: startCameraPosition.x - value.predictedEndTranslation.width,
                                                           y: startCameraPosition.y + value.predictedEndTranslation.height),
                                               duration: duration,
                                               delay: 0,
                                               usingSpringWithDamping: 9.5,
                                               initialSpringVelocity: 1.0)
                
//                @objc class func move(to location: CGPoint,
//                                      duration: TimeInterval,
//                                      delay: TimeInterval,
//                                      usingSpringWithDamping dampingRatio: CGFloat,
//                                      initialSpringVelocity velocity: CGFloat) -> SKAction {

                    
                scene.gameCamera.run(moveAction, withKey: "map-pan-momentum")
//                if let history = history, history.count > 1 && selectedNode != nil {
//                    var vx:CGFloat = 0.0
//                    var vy:CGFloat = 0.0
//                    var previousTouchInfo:TouchInfo?
//                    // Adjust this value as needed
//                    let maxIterations = 3
//                    var numElts:Int = min(history.count, maxIterations)
//                    // Loop over touch history
//                    for index in 0..<numElts {
//                        let touchInfo = history[index]
//                        let location = touchInfo.location
//                        if let previousTouch = previousTouchInfo {
//                            // Step 1
//                            let dx = location.x - previousTouch.location.x
//                            let dy = location.y - previousTouch.location.y
//                            // Step 2
//                            let dt = CGFloat(touchInfo.time - previousTouch.time)
//                            // Step 3
//                            vx += dx / dt
//                            vy += dy / dt
//                        }
//                        previousTouchInfo = touchInfo
//                    }
//                    let count = CGFloat(numElts-1)
//                    // Step 4
//                    let velocity = CGVectorMake(vx/count,vy/count)
//                    selectedNode?.physicsBody?.velocity = velocity
//                }
//                // Step 5
//                selectedNode = nil
//                history = nil
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }
    
    var body: some View {
        ZStack {
#if DEBUG
            if #available(iOS 15.0, *) {
                SpriteView(scene: scene, debugOptions: [.showsFPS,
                                                        .showsNodeCount,
                                                        .showsDrawCount])
                    .ignoresSafeArea()
                    .gesture(simpleDrag)
                if let fingerLocation = fingerLocation {
                    Circle()
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width: 44, height: 44)
                        .position(fingerLocation)
                }
            }
            else {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
                    .gesture(simpleDrag)
            }
#else
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .gesture(simpleDrag)
#endif
        }
    }
}
