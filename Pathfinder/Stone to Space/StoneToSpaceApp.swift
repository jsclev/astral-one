import SpriteKit
import SwiftUI
import Engine

@main
struct StoneToSpaceApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                StoneToSpaceView()
            }
            .statusBar(hidden: true)
        }
    }
}
