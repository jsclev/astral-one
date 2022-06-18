import SpriteKit
import SwiftUI
import Engine

@main
struct PathfinderApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                PathfinderView()
            }
            .statusBar(hidden: true)
        }
    }
}
