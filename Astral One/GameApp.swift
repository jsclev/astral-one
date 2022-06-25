import SpriteKit
import SwiftUI
import Engine

@main
struct GameApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                GameView()
            }
            .statusBar(hidden: true)
        }
    }
}
