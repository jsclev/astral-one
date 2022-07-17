import Foundation
import Combine
import SpriteKit
import SwiftUI

public class AIDebugMapLayer {
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
                SKLabelNode(fontNamed: "Arial")
            }
        }
        
        for row in 0..<self.player.map.height {
            for col in 0..<self.player.map.width {
                let position = Position(row: row, col: col)
                
                let labelNode = labelNodes[row][col]
                labelNode.fontSize = 12
                labelNode.horizontalAlignmentMode = .center
                labelNode.position = CGPoint(x: mapView.getCenterOf(position: position).x,
                                             y: mapView.getCenterOf(position: position).y - 25.0)
                node.addChild(labelNode)
            }
        }
        
        player.$agentMap
            .sink(receiveValue: { agentMap in
                for row in 0..<self.player.map.height {
                    for col in 0..<self.player.map.width {
                        let score = agentMap[row][col]
                        var text = ""
                        
                        if score.value > 0.0 {
                            text = String(format: "%.1f", score.value)
                        }
                        
                        self.labelNodes[row][col].text = text
                    }
                }
            })
            .store(in: &cancellable)
        
        game.$aiDebug
            .sink(receiveValue: { aiDebug in
                self.node.isHidden = !aiDebug
            })
            .store(in: &cancellable)
        
    }
}
