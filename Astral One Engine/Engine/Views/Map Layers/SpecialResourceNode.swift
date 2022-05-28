import Foundation
import SpriteKit

public class SpecialResourceNode: SKSpriteNode {
    private let specialResource: SpecialResource
    
    public init(game: Game, specialResource: SpecialResource) {
        self.specialResource = specialResource
        
        var assetName = game.theme.name + "/Resources/"
        
        if specialResource == SpecialResource.Buffalo {
            assetName += "buffalo"
        }
        else if specialResource == SpecialResource.Coal {
            assetName += "coal"
        }
        else if specialResource == SpecialResource.Fish {
            assetName += "fish"
        }
        else if specialResource == SpecialResource.Fruit {
            assetName += "fruit"
        }
        else if specialResource == SpecialResource.Furs {
            assetName += "furs"
        }
        else if specialResource == SpecialResource.Game {
            assetName += "game"
        }
        else if specialResource == SpecialResource.Gems {
            assetName += "gems"
        }
        else if specialResource == SpecialResource.Gold {
            assetName += "gold"
        }
        else if specialResource == SpecialResource.Iron {
            assetName += "iron"
        }
        else if specialResource == SpecialResource.Ivory {
            assetName += "ivory"
        }
        else if specialResource == SpecialResource.Oasis {
            assetName += "oasis"
        }
        else if specialResource == SpecialResource.Oil {
            assetName += "oil"
        }
        else if specialResource == SpecialResource.Peat {
            assetName += "peat"
        }
        else if specialResource == SpecialResource.Pheasant {
            assetName += "pheasant"
        }
        else if specialResource == SpecialResource.Silk {
            assetName += "silk"
        }
        else if specialResource == SpecialResource.Spice {
            assetName += "spice"
        }
        else if specialResource == SpecialResource.Whales {
            assetName += "whales"
        }
        else if specialResource == SpecialResource.Wheat {
            assetName += "wheat"
        }
        else if specialResource == SpecialResource.Wine {
            assetName += "wine"
        }
        
        let texture = SKTexture(imageNamed: assetName)
        super.init(texture: texture, color: UIColor.systemPink, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
