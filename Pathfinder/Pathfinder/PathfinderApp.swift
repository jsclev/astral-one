import SpriteKit
import SwiftUI

@main
struct PathfinderApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                PathfinderView()
            }
        }
    }
}
