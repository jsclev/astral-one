import SpriteKit
import SwiftUI
import Engine
import Combine

class PathfinderCamera: SKCameraNode {
    @ObservedObject var game: Game
    
    private var cancellable = Set<AnyCancellable>()
    
    let startPositionIcon = SKSpriteNode(imageNamed: "square-wooden-button")
    let calculatePathIcon = SKSpriteNode(imageNamed: "square-wooden-button")
    let positionLabel = SKLabelNode(fontNamed: "Arial Bold")
    
    init(game: Game) {
        self.game = game
        
        startPositionIcon.size = CGSize(width: 40.0, height: 35.0)
        calculatePathIcon.size = CGSize(width: 40.0, height: 35.0)
        
        startPositionIcon.zPosition = Layer.hud
        calculatePathIcon.zPosition = Layer.hud
        
        startPositionIcon.name = "set-start-position"
        calculatePathIcon.name = "calculate-path"
        
        positionLabel.fontSize = 20
        positionLabel.horizontalAlignmentMode = .left
        positionLabel.zPosition = Layer.hud
        
        
        super.init()
        
        name = "camera"
        
        game.$selectedMapPosition
            .dropFirst()
            .sink(receiveValue: { mapPosition in
//                self.updatePositionLabel(pos: tapLocation)
        })
        .store(in: &cancellable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        updatePositionLabel(pos: position)
        
        if let scene = self.scene {
            let topIconEdge: CGFloat = (scene.size.height / 2.0) - 25.0
            let verticalSpacer: CGFloat = 45.0
            let leftIconEdge: CGFloat = 65.0 + scene.size.width / -2.0
            
            startPositionIcon.position = CGPoint(x: leftIconEdge, y: topIconEdge)
            calculatePathIcon.position = CGPoint(x: leftIconEdge, y: topIconEdge - verticalSpacer)
            positionLabel.position = CGPoint(x: leftIconEdge, y: topIconEdge - 2 * verticalSpacer)
        }
        
//        addChild(startPositionIcon)
//        addChild(calculatePathIcon)
//        addChild(positionLabel)
    }
    
    func updatePositionLabel(pos: CGPoint) {
        let x = String(format: "%.0f", pos.x)
        let y = String(format: "%.0f", pos.y)

        positionLabel.text = "[\(x),\(y)]"
    }
    
}
