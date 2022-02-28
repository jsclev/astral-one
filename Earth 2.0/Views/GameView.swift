import SpriteKit
import SwiftUI

struct GameView: View {
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil // 1
    
    var scene = GameScene(size: CGSize(width: UIScreen.main.bounds.width,
                                       height: UIScreen.main.bounds.height))
    var camera = SKCameraNode()
    
    init() {
        scene.camera = self.camera
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
                print("\(self.location)")
                self.camera.position = self.location
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
