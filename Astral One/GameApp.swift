import SpriteKit
import SwiftUI
import Engine

@main
struct GameApp: App {
    @StateObject var game: Game
    
    init() {
        let db = Db(fullRefresh: true)
        let game = Game(db: db)
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
