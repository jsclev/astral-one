import Foundation
import SpriteKit

public class FounderNode: SKSpriteNode {
    private let game: Game
    private let cityCreator: Settler
    
    public init(game: Game, cityCreator: Settler) {
        self.game = game
        self.cityCreator = cityCreator
        
        let texture = SKTexture(imageNamed: cityCreator.assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touched it dude")
        game.selectedCityCreator = cityCreator
    }
}
