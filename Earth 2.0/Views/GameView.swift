import SpriteKit
import SwiftUI

struct GameView: View {
    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil // 1
    
    var camera = SKCameraNode()
    var mapViewModel = MapViewModel()
    var scene: GameScene
    
    init() {
        scene = GameScene(mapViewModel: mapViewModel)
        scene.camera = self.camera
        self.camera.position = mapViewModel.cameraPosition
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
                mapViewModel.setCameraPosition(self.location)
                print("\(self.location)")
                self.camera.position = mapViewModel.cameraPosition
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location // 2
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
            .gesture(
                simpleDrag.simultaneously(with: fingerDrag)
            )
    }
}
