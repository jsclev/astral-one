import SpriteKit
import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: Game

    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    
//    var gameCamera = SKCameraNode()
    var mapViewModel = MapViewModel()
    var scene: GameScene
    @GestureState private var cameraPosition = CGPoint.zero
    
    init() {
        scene = GameScene(mapViewModel: mapViewModel)
//        scene.camera = gameCamera
//        scene.anchorPoint = CGPoint.zero

    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
                mapViewModel.moveCamera(translation: value.translation)
                scene.gameCamera.position = mapViewModel.cameraPosition
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
                                                        .showsNodeCount])
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

            ScrollView(showsIndicators: false) {
                let buttonSize = 80.0
                
                Button {
                    scene.toggleTexture()
                } label: {
                    Image("building0")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                } label: {
                    Image("building1")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                } label: {
                    Image("building2")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                } label: {
                    Image("building3")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                } label: {
                    Image("building4")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                } label: {
                    Image("building5")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                } label: {
                    Image("building6")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                } label: {
                    Image("building7")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                } label: {
                    Image("building8")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    game.showFPS = !game.showFPS
                } label: {
                    Image("building9")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
            }
            .background(Color.black)
        }
    }
}
