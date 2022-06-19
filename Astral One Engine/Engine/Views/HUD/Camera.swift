import SpriteKit
import SwiftUI
import Combine

public class Camera: SKCameraNode {
    @ObservedObject var game: Game
    
    private var cancellable = Set<AnyCancellable>()
    
    private let nextTurnButton: NextTurnButton
    let startPositionIcon = SKSpriteNode(imageNamed: "square-wooden-button")
    let calculatePathIcon = SKSpriteNode(imageNamed: "square-wooden-button")
    let positionLabel = SKLabelNode(fontNamed: "Arial Bold")
    
    private let padding: CGFloat
    
    public init(game: Game) {
        self.game = game
        
        padding = game.canvasSize.width * 0.015
        
        nextTurnButton = NextTurnButton(game: game)
        nextTurnButton.position = CGPoint.zero
        print(game.canvasSize)
        nextTurnButton.position = CGPoint(x: (game.canvasSize.width / 2) - nextTurnButton.size.width / 2 - padding,
                                          y: -(game.canvasSize.height / 2) + nextTurnButton.size.height / 2 + padding)
        print(nextTurnButton.position)
//        nextTurnButton.size = CGSize(width: 100.0, height: 100.0)
        startPositionIcon.size = CGSize(width: 40.0, height: 35.0)
        calculatePathIcon.size = CGSize(width: 40.0, height: 35.0)
        
        startPositionIcon.zPosition = Layer.hud
        calculatePathIcon.zPosition = Layer.hud
        nextTurnButton.zPosition = Layer.hud
        
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
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show() {
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
        addChild(nextTurnButton)
        
        print("Camera size: \(self.frame.size)")
    }
    
    public func updatePositionLabel(pos: CGPoint) {
        let x = String(format: "%.0f", pos.x)
        let y = String(format: "%.0f", pos.y)
        
        positionLabel.text = "[\(x),\(y)]"
    }
    
}
