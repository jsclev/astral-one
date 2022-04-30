import Foundation
import SpriteKit

public class UnitNode: SKSpriteNode {
    private let game: Game
    private let unit: Unit
    
    public override var isUserInteractionEnabled: Bool {
        set { }
        get { return true }
    }
    
    public init(game: Game, unit: Unit) {
        self.game = game
        self.unit = unit
        
        let texture = SKTexture(imageNamed: unit.assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
        
        self.name = "\(unit.name)_"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        game.selectMapPosition(mapPosition: MapPosition(row: 0, col: 0))

    }
}
