import SpriteKit
import SwiftUI
import Astral_One_Engine

struct PathfinderView: View {
    @EnvironmentObject var game: Game
    
    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    @GestureState private var cameraPosition = CGPoint.zero

    var mapViewModel = MapViewModel()
    var scene: PathfinderScene
    
    init() {
        scene = PathfinderScene(mapViewModel: mapViewModel)
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                let finalTranslationX = value.translation.width * scene.gameCamera.xScale
                let finalTranslationY = value.translation.height * scene.gameCamera.yScale
                newLocation.x += finalTranslationX
                newLocation.y += finalTranslationY
                self.location = newLocation
                mapViewModel.moveCamera(translation: CGSize(width: finalTranslationX,
                                                            height: finalTranslationY))
                scene.gameCamera.position = mapViewModel.cameraPosition
                scene.gameCamera.updatePositionLabel()
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }.onEnded { value in
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
