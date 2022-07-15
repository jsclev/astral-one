import Foundation
import Combine
import SpriteKit
import SwiftUI

public class AIDebugMapLayer {
    private let player: Player
    private let scene: SKScene
    private let node: SKNode
    private let scoreNodes: [[SKLabelNode]]
    private var cancellable = Set<AnyCancellable>()
    
    public init(player: Player, scene: SKScene, mapView: MapManager) {
        self.player = player
        self.scene = scene
        
        node = SKNode()
        node.zPosition = Layer.unitPath
        
        scoreNodes = (0..<player.map.width).map { _ in
            (0..<player.map.height).map { _ in
                SKLabelNode(fontNamed: "Arial Bold")
            }
        }

        for row in 0..<self.player.map.height {
            for col in 0..<self.player.map.width {
                let labelNode = scoreNodes[row][col]
                let position = CGPoint(x: mapView.getCenterOf(position: Position(row: row, col: col)).x,
                                       y: mapView.getCenterOf(position: Position(row: row, col: col)).y - 25.0)
                labelNode.position = position
                labelNode.fontSize = 12
                labelNode.horizontalAlignmentMode = .center
//                labelNode.fontColor = SKColor(red: 1.0, green: 0.647, blue: 0.0, alpha: 1.0)

                node.addChild(labelNode)
            }
        }
        
        scene.addChild(node)

        self.player.$agentMap
            .sink(receiveValue: { agentMap in
                for row in 0..<self.player.map.height {
                    for col in 0..<self.player.map.width {
                        let score = agentMap[row][col]
                        var text = ""
                        
                        if score.value > 0.0 {
                           text = String(format: "%.1f", score.value)
                        }

                        self.scoreNodes[row][col].text = text
                    }
                }
            })
            .store(in: &cancellable)
        
        self.player.game.$aiDebug
            .sink(receiveValue: { aiDebug in
                self.node.isHidden = !aiDebug
            })
            .store(in: &cancellable)
    }
}
