import Combine
import Foundation
import SpriteKit
import SwiftUI

public class TileCoordsMapLayer {
    private let player: Player
    private let scene: SKScene
    private let node: SKNode
    private let labelNodes: [[SKLabelNode]]
    private var cancellable = Set<AnyCancellable>()
    
    public init(game: Game, player: Player, scene: SKScene, mapView: MapManager) {
        self.player = player
        self.scene = scene
        
        node = SKNode()
        node.zPosition = Layer.unitPath
        scene.addChild(node)

        labelNodes = (0..<player.map.width).map { _ in
            (0..<player.map.height).map { _ in
                SKLabelNode(fontNamed: "Arial Bold")
            }
        }
        
        for row in 0..<self.player.map.height {
            for col in 0..<self.player.map.width {
                let position = Position(row: row, col: col)
                
                let labelNode = labelNodes[row][col]
                labelNode.fontColor = UIColor.black
                labelNode.fontSize = 14
                labelNode.horizontalAlignmentMode = .center
                labelNode.text = "(\(row), \(col))"
                labelNode.position = CGPoint(x: mapView.getCenterOf(position: position).x,
                                             y: mapView.getCenterOf(position: position).y)
                if row == 7 && col == 10 {
                    labelNode.text = "ABC"
                }
                else if row == 7 && col == 10 {
                    labelNode.text = "ABC"
                }
                else if row == 7 && col == 10 {
                    labelNode.text = "ABC"
                }
                else if row == 18 && col == 10 {
                    labelNode.text = "ABC"
                }
                else if row == 7 && col == 10 {
                    labelNode.text = "ABC"
                }
                else if row == 7 && col == 10 {
                    labelNode.text = "ABC"
                }
                else if row > (-col + 28) &&
                   row < (-col + 109) &&
                   row < (col + 24) &&
                   row > (col - 25) {
                    labelNode.text = "(\(row), \(col))"
                }
                else {
                    labelNode.text = "X"
                }
                
                node.addChild(labelNode)
            }
        }
        
        game.$tileCoords
            .sink(receiveValue: { toggle in
                self.node.isHidden = !toggle
            })
            .store(in: &cancellable)
    }
}
