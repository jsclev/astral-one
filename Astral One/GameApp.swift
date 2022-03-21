import SpriteKit
import SwiftUI
import Astral_One_Engine

@main
struct GameApp: App {
    @StateObject var game: Game
    
    init() {
        let game = Game()
        self._game = StateObject(wrappedValue: game)
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                GameView()
                    .environmentObject(game)
            }
        }
    }
}
