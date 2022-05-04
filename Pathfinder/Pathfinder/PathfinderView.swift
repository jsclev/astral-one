import SpriteKit
import SwiftUI
import Engine

struct PathfinderView: View {
    var game: Game
    
    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    @GestureState private var cameraPosition = CGPoint.zero

    var mapViewModel = MapViewModel()
    var scene: PathfinderScene
    
    init() {
        game = Game(refreshDb: true)
        scene = PathfinderScene(game: game, mapViewModel: mapViewModel)
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
//                print(value.translation)
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
                
//                let velocity = CGSize(
//                    width:  value.predictedEndLocation.x + value.location.x,
//                    height: value.predictedEndLocation.y + value.location.y
//                )
//
//                print(velocity)
//
//                let moveCamera = SKAction.move(to: CGPoint(x: value.predictedEndLocation.x - value.location.x,
//                                                           y: value.predictedEndLocation.y - value.location.y), duration: 2.0)
////                scene.gameCamera.run(moveCamera)
//
//                if velocity.height > 500.0 {
//                    // Moving down fast
//                }
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
