import SpriteKit
import SwiftUI

@main
struct AstralOneApp: App {
    
    var body: some Scene {
        // Configure the view.
        //      let skView = self.view as! SKView
        //      skView.showsFPS = true
        //      skView.showsNodeCount = true
        //      skView.ignoresSiblingOrder = true
        
        // Create and configure the scene.
        //      let scene = GameScene(size: CGSize(width: 375, height: 667))
        //      scene.scaleMode = .aspectFill
        
        // Present the scene.
        //      skView.presentScene(scene)
        
        WindowGroup {
            GameView()
                .environment(\.colorScheme, .dark)
        }
    }
}
