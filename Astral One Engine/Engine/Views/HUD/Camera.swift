import SpriteKit
import SwiftUI
import Combine

public class Camera: SKCameraNode {
    private let game: Game
    private let player: Player
    private let nextTurnButton: NextTurnButton
    private let researchButton: ResearchButton

    private var cancellable = Set<AnyCancellable>()
    
    let positionLabel = SKLabelNode(fontNamed: "Arial Bold")
    private let padding: CGFloat
    
    public init(game: Game, player: Player) {
        self.game = game
        self.player = player
        
        padding = game.canvasSize.width * 0.015
        
        nextTurnButton = NextTurnButton(game: game)
        nextTurnButton.position = CGPoint(x: (game.canvasSize.width / 2) - (nextTurnButton.size.width / 2) - padding,
                                          y: -(game.canvasSize.height / 2) + (nextTurnButton.size.height / 2) + padding)

        let turnIndicator = TurnView(game: game)
        turnIndicator.position = CGPoint(x: (game.canvasSize.width / 2) - (turnIndicator.size.width / 2) - padding,
                                         y: (game.canvasSize.height / 2) - (turnIndicator.size.height) - 2.0 * padding)
        
        let notification = NotificationNode(player: player)
        notification.position = CGPoint(x: -(game.canvasSize.width / 2) + (notification.size.width / 2) + padding,
                                         y: -(game.canvasSize.height / 2) + (notification.size.height) + 1.5*padding)
        
        researchButton = ResearchButton(game: game)
        researchButton.position = CGPoint.zero
        researchButton.position = CGPoint(x: -(game.canvasSize.width / 2) + (nextTurnButton.size.width / 2) + padding,
                                          y: (game.canvasSize.height / 2) - (nextTurnButton.size.height / 2) - padding)

        nextTurnButton.zPosition = Layer.hud
        researchButton.zPosition = Layer.hud
        
        positionLabel.fontSize = 20
        positionLabel.horizontalAlignmentMode = .left
        positionLabel.zPosition = Layer.hud
        
        super.init()
        
        name = "camera"
        
        addChild(turnIndicator)
        addChild(notification)
        addChild(nextTurnButton)
        addChild(researchButton)
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
            
            positionLabel.position = CGPoint(x: leftIconEdge, y: topIconEdge - 2 * verticalSpacer)
        }
    }
    
    public func updatePositionLabel(pos: CGPoint) {
        let x = String(format: "%.0f", pos.x)
        let y = String(format: "%.0f", pos.y)
        
        positionLabel.text = "[\(x),\(y)]"
    }
    
}
