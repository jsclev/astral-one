import Foundation
import SpriteKit
import SwiftUI
import Engine

struct GameView: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @State private var isAnimating = false
    @State private var dragAnimationCount = 0
    
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
        DragGesture(minimumDistance: isAnimating ? 5 : 5)
            .onChanged { value in
                
                if !isDragging {
                    isDragging = true
                    startCameraPosition = scene.gameCamera.position
                    scene.gameCamera.removeAction(forKey: "map-pan-momentum")
                }
                
                scene.gameCamera.position = CGPoint(x: startCameraPosition.x - (value.translation.width * mapViewModel.scale),
                                                    y: startCameraPosition.y + (value.translation.height * mapViewModel.scale))
                
                // Get the offset between the start location and the camera's position
                //                print("--------------------------------------------------------------------------")
                //                print("translation: [\(value.translation.width), \(value.translation.height)]")
                //                print("finger location: \(value.location)")
                //                print("start location: \(value.startLocation)")
                //                print("Camera position: \(scene.gameCamera.position)")
            }
            .onEnded { value in
                let temp = (value.predictedEndTranslation.width - value.translation.width)
                let temp2 = (value.predictedEndTranslation.height - value.translation.height)
                let magnitude = sqrt(
                    (temp * temp +
                     temp2 * temp2))
                
                isDragging = false
                
                var duration = (magnitude/2000) + 0.8
                if duration < 0.8 {
                    duration = 0.8
                }
                //                print("magnitude: \(magnitude)")
                //                print("duration: \(duration)")
                
                let moveAction = SKAction.move(to: CGPoint(x: startCameraPosition.x - (value.predictedEndTranslation.width * mapViewModel.scale),
                                                           y: startCameraPosition.y + (value.predictedEndTranslation.height * mapViewModel.scale)),
                                               duration: duration,
                                               delay: 0,
                                               usingSpringWithDamping: 9.5,
                                               initialSpringVelocity: 1.0)
                if (magnitude > 10) {
                    isAnimating = true
                    dragAnimationCount += 1
                    let currentAnimationCount = dragAnimationCount
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        if dragAnimationCount == currentAnimationCount {
                            isAnimating = false
                            dragAnimationCount = 0
                        }
                    }
                } else {
                    isAnimating = false
                }
                
                scene.gameCamera.run(moveAction, withKey: "map-pan-momentum")
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
                .simultaneousGesture(simpleDrag)
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
