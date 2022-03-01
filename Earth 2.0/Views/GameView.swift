import SpriteKit
import SwiftUI

struct GameView: View {
    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
//    @State var lastDragPosition: DragGesture.Value?

    
    var camera = SKCameraNode()
    var mapViewModel = MapViewModel()
    var scene: GameScene
    @GestureState private var cameraPosition = CGPoint.zero
    
    init() {
        scene = GameScene(mapViewModel: mapViewModel)
        scene.camera = self.camera
        scene.anchorPoint = CGPoint.zero
        self.camera.position = mapViewModel.cameraPosition
//        let zoomOutAction = SKAction.scale(to: 5, duration: 1)
//        scene.camera.run(zoomOutAction)
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
                mapViewModel.moveCamera(translation: value.translation)
//                print("Translation value: \(value.translation)")
//                print("\(self.location)")
                self.camera.position = mapViewModel.cameraPosition
                
//                self.lastDragPosition = value
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }.onEnded { value in
//                let timeDiff = value.time.timeIntervalSince(self.lastDragPosition!.time)
//                let speed: CGFloat = CGFloat(value.translation.height - self.lastDragPosition!.translation.height) / CGFloat(timeDiff)
//                print("Speed is \(speed)")
                
//                let zoomInAction = SKAction.scale(to: 0.5, duration: 1)
//                camera.run(zoomInAction)
                mapViewModel.resetCamera()
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .gesture(simpleDrag)
    }
}
