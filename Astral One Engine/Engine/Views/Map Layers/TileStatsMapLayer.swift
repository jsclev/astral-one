import Foundation
import Combine
import SpriteKit
import SwiftUI

public class TileStatsMapLayer {
    let player: Player
    let scene: SKScene
    private var cancellable = Set<AnyCancellable>()
    
    public init(player: Player, scene: SKScene, mapView: MapManager) {
        self.player = player
        self.scene = scene
    
        self.player.$agentMap
            .sink(receiveValue: { scoreMap in
                for row in 0..<scoreMap.count {
                    for col in 0..<scoreMap[row].count {
                        print("[\(row), \(col)]: \(scoreMap[row][col].value)")
//                        let position = Position(row: row, col: col)
//                        let tile = self.player.map.tile(at: position)
//
//                        let point = mapView.getCenterPointOf(position: position)
//                        //                let label = SKLabelNode(fontNamed: "Arial")
//
//                        let foodLabel = SKLabelNode(fontNamed: "Arial")
//                        foodLabel.text = "F: \(tile.food), P: \(tile.production), T: \(tile.trade)"
//                        //                foodLabel.fontColor = UIColor.black
//                        foodLabel.fontSize = 11
//                        foodLabel.position = point
//                        foodLabel.zPosition = Layer.tileStats
//                        scene.addChild(foodLabel)
                    }
                }
            })
            .store(in: &cancellable)
    }
    
}
