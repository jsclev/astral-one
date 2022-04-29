import Foundation
import SpriteKit

public class UnitNode: SKSpriteNode {
    private let game: Game
    
    public override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
    
    public init(game: Game, name: String, imageNamed: String) {
        self.game = game
        
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
        
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        game.selectMapPosition(mapPosition: MapPosition(row: 0, col: 0))

    }
}
