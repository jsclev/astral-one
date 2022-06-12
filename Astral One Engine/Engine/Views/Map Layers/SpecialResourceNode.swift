import Foundation
import SpriteKit

public class SpecialResourceNode: SKSpriteNode {
    private let specialResource: SpecialResourceType
    
    public init(game: Game, specialResource: SpecialResourceType) {
        self.specialResource = specialResource
        
        var assetName = game.theme.name + "/Resources/"
        
        if specialResource == SpecialResourceType.Buffalo {
            assetName += "buffalo"
        }
        else if specialResource == SpecialResourceType.Coal {
            assetName += "coal"
        }
        else if specialResource == SpecialResourceType.Fish {
            assetName += "fish"
        }
        else if specialResource == SpecialResourceType.Fruit {
            assetName += "fruit"
        }
        else if specialResource == SpecialResourceType.Furs {
            assetName += "furs"
        }
        else if specialResource == SpecialResourceType.Game {
            assetName += "game"
        }
        else if specialResource == SpecialResourceType.Gems {
            assetName += "gems"
        }
        else if specialResource == SpecialResourceType.Gold {
            assetName += "gold"
        }
        else if specialResource == SpecialResourceType.Iron {
            assetName += "iron"
        }
        else if specialResource == SpecialResourceType.Ivory {
            assetName += "ivory"
        }
        else if specialResource == SpecialResourceType.Oasis {
            assetName += "oasis"
        }
        else if specialResource == SpecialResourceType.Oil {
            assetName += "oil"
        }
        else if specialResource == SpecialResourceType.Peat {
            assetName += "peat"
        }
        else if specialResource == SpecialResourceType.Pheasant {
            assetName += "pheasant"
        }
        else if specialResource == SpecialResourceType.Silk {
            assetName += "silk"
        }
        else if specialResource == SpecialResourceType.Spice {
            assetName += "spice"
        }
        else if specialResource == SpecialResourceType.Whales {
            assetName += "whales"
        }
        else if specialResource == SpecialResourceType.Wheat {
            assetName += "wheat"
        }
        else if specialResource == SpecialResourceType.Wine {
            assetName += "wine"
        }
        
        let texture = SKTexture(imageNamed: assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
