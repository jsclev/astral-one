import Foundation
import SpriteKit

public class CityNode: SKSpriteNode {
//    private let game: Game
    private let city: City
    
    public override var isUserInteractionEnabled: Bool {
        set { }
        get { return true }
    }
    
    public init(city: City) {
//        self.game = game
        self.city = city
        
        let texture = SKTexture(imageNamed: city.assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
        
        self.name = "\(city.name)_"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(city.name), position [\(city.position.row),\(city.position.col)]")
//        game.selectMapPosition(mapPosition: MapPosition(row: 0, col: 0))
        
    }
}
