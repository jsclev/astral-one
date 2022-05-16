import Foundation
import SpriteKit

public class TileCoordsMapLayer {
    
    public init(game: Game, scene: SKScene, mapView: MapView, layerIndex: CGFloat) {
        for row in 0..<game.map.height {
            for col in 0..<game.map.width {
                let node = SKLabelNode(fontNamed: "Arial")
                node.fontSize = 12
                node.horizontalAlignmentMode = .center
                node.position = mapView.getCenterPointOf(position: Position(row: row, col: col))
                node.text = "\(row),\(col)"
                node.zPosition = layerIndex
                
                scene.addChild(node)
            }
        }
    }
}
