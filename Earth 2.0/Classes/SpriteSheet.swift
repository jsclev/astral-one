import SpriteKit

class SpriteSheet {
    let texture: SKTexture
    let rows: Int
    let columns: Int
    var margin: CGFloat=0
    var spacing: CGFloat=0
    var frameSize: CGSize {
        return CGSize(width: (self.texture.size().width-(self.margin*2+self.spacing*CGFloat(self.columns-1)))/CGFloat(self.columns),
                      height: (self.texture.size().height-(self.margin*2+self.spacing*CGFloat(self.rows-1)))/CGFloat(self.rows))
    }
    
    init(texture: SKTexture, rows: Int, columns: Int, spacing: CGFloat, margin: CGFloat) {
        self.texture=texture
        self.rows=rows
        self.columns=columns
        self.spacing=spacing
        self.margin=margin
        
    }
    
    convenience init(texture: SKTexture, rows: Int, columns: Int) {
        self.init(texture: texture, rows: rows, columns: columns, spacing: 0, margin: 0)
    }
    
    func textureForColumn(column: Int, row: Int)->SKTexture? {
        if !(0...self.rows ~= row && 0...self.columns ~= column) {
            //location is out of bounds
            return nil
        }
        
        var textureRect=CGRect(x: 216,
                               y: 930,
                               width: 50,
                               height: 50)
        
        //        var textureRect=CGRect(x: self.margin+CGFloat(column)*(self.frameSize.width+self.spacing)-self.spacing,
        //                               y: self.margin+CGFloat(row)*(self.frameSize.height+self.spacing)-self.spacing,
        //                               width: self.frameSize.width,
        //                               height: self.frameSize.height)
        
        //        textureRect=CGRect(x: textureRect.origin.x/self.texture.size().width, y: textureRect.origin.y/self.texture.size().height,
        //            width: textureRect.size.width/self.texture.size().width, height: textureRect.size.height/self.texture.size().height)
        return SKTexture(rect: textureRect, in: self.texture)
    }
    
}

extension SKSpriteNode {
    func loadTextures(atlas: String, prefix: String,
                      startsAt: Int, stopsAt: Int) -> [SKTexture] {
        var textureArray = [SKTexture]()
        let textureAtlas = SKTextureAtlas(named: atlas)
        for i in startsAt...stopsAt {
            let textureName = "\(prefix)\(i)"
            let temp = textureAtlas.textureNamed(textureName)
            textureArray.append(temp)
        }
        return textureArray
    }
    
    func startAnimation(textures: [SKTexture],
                        speed: Double,
                        name: String,
                        count: Int,
                        resize: Bool,
                        restore: Bool) {
        if (action(forKey: name) == nil) {
            let animation = SKAction.animate(with: textures, timePerFrame: speed,
                                             resize: resize, restore: restore)
            if count == 0 {
                let repeatAction = SKAction.repeatForever(animation)
                run(repeatAction, withKey: name)
            } else if count == 1 {
                run(animation, withKey: name)
            } else {
                let repeatAction = SKAction.repeat(animation, count: count)
                run(repeatAction, withKey: name)
            }
        }
    }
}
