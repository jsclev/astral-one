import SpriteKit
import SwiftUI

struct UnitMenuView: View {
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
  
  var body: some View {
    SpriteView(scene: scene)
      .ignoresSafeArea()
      .gesture(simpleDrag)
  }
}
