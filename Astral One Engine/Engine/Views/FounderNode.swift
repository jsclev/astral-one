import Foundation
import SpriteKit

public class FounderNode: SKSpriteNode {
    private let game: Game
    private let founder: Founder
    
    public init(game: Game, founder: Founder) {
        self.game = game
        self.founder = founder
        
        let texture = SKTexture(imageNamed: founder.assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        game.selectedFounder = founder
    }
}
