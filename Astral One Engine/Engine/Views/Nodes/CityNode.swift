import Foundation
import SpriteKit

internal class CityNode: SKSpriteNode {
    private let city: City
    
    public override var isUserInteractionEnabled: Bool {
        set { }
        get { return true }
    }
    
    public init(city: City) {
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
    }
}

internal class CityTileMapNode: SKTileMapNode {
    
//    public override var isUserInteractionEnabled: Bool {
//        set { }
//        get { return true }
//    }
    
    internal override init(tileSet: SKTileSet,
                  columns: Int,
                  rows: Int,
                  tileSize: CGSize) {
        super.init(tileSet: tileSet,
                   columns: columns,
                   rows: rows,
                   tileSize: tileSize)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchedasfasefasef")
//        print("\(city.name), position [\(city.position.row),\(city.position.col)]")
    }
}
