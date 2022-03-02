import SpriteKit
import SwiftUI

struct GameView: View {
    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    
    var camera = SKCameraNode()
    var mapViewModel = MapViewModel()
    var scene: GameScene
    @GestureState private var cameraPosition = CGPoint.zero
    
    init() {
        scene = GameScene(mapViewModel: mapViewModel)
        scene.camera = self.camera
        scene.anchorPoint = CGPoint.zero
        self.camera.position = mapViewModel.cameraPosition
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
                mapViewModel.moveCamera(translation: value.translation)
                self.camera.position = mapViewModel.cameraPosition
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
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .gesture(simpleDrag)
            ScrollView(showsIndicators: false) {
                let buttonSize = 80.0
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
                } label: {
                    Image("building0")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
                } label: {
                    Image("building1")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
                } label: {
                    Image("building2")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
                } label: {
                    Image("building3")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
                } label: {
                    Image("building4")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
                } label: {
                    Image("building5")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
                } label: {
                    Image("building6")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
                } label: {
                    Image("building7")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
                } label: {
                    Image("building8")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                }
                
                Button {
                    scene.toggleTexture()
                    self.camera.position = mapViewModel.cameraPosition
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
