import Foundation
import SpriteKit
import SwiftUI
import Engine

struct StoneToSpaceView: View {
    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    @GestureState private var cameraPosition = CGPoint.zero

    var mapViewModel = MapViewModel()
    var scene: StoneToSpaceScene
    
    init() {
        scene = StoneToSpaceScene(mapViewModel: mapViewModel)
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                let finalTranslationX = value.translation.width * scene.gameCamera.xScale
                let finalTranslationY = value.translation.height * scene.gameCamera.yScale
                newLocation.x += finalTranslationX
                newLocation.y += finalTranslationY
                location = newLocation
                mapViewModel.moveCamera(translation: CGSize(width: finalTranslationX,
                                                            height: finalTranslationY))
                scene.gameCamera.position = mapViewModel.cameraPosition
                scene.gameCamera.updatePositionLabel(pos: scene.gameCamera.position)
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
            .onEnded { value in
                mapViewModel.resetCamera()

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
        HStack {
#if DEBUG
            if #available(iOS 15.0, *) {
                SpriteView(scene: scene, debugOptions: [.showsFPS,
                                                        .showsNodeCount,
                                                        .showsDrawCount])
                    .ignoresSafeArea()
                    .gesture(simpleDrag)
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
