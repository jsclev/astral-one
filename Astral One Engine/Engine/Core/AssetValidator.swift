import Foundation
import SpriteKit

public class AssetValidator {
    public init() {
        
    }
    
    public func validate() {
        if let _ = SKTileSet(named: Constants.tilesetName) {
            print("Found main tileset")
        }
        else {
            print("Unable to find main \"\(Constants.tilesetName)\" tile set.")
        }
        
//        if let path = Bundle.main.url(forResource: Constants.tilesetName, withExtension: ".tsx") {
//            if let parser = XMLParser(contentsOf: path) {
//                parser.delegate = self
//                parser.parse()
//            }
//        }
//        else {
//            fatalError("Unable to find Tiled tileset \"\(Constants.tilesetName).tsx\" in app bundle.")
//        }
    }
}
