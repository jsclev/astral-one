import SpriteKit
import SwiftUI
import Combine

public class Camera: SKCameraNode {
    private let game: Game
    private let player: Player
    private let view: SKView
    private let statsBar: StatsBar
    private let nextTurnButton: NextTurnButton
    private let researchButton: ResearchButton
    private let turnIndicator: TurnIndicator
    private let notificationIndicator: NotificationIndicator
    private let horizontalPadding: CGFloat
    private let verticalPadding: CGFloat
    private var cancellable = Set<AnyCancellable>()
    private let neAnchorPoint: CGPoint
    private let nwAnchorPoint: CGPoint
//    private let wAnchorPoint: CGPoint
//    private let swAnchorPoint: CGPoint
    
    public init(game: Game, player: Player, view: SKView) {
        self.game = game
        self.player = player
        self.view = view
        
        horizontalPadding = game.canvasSize.width * 0.014
        verticalPadding = game.canvasSize.width * 0.011

        statsBar = StatsBar(game: game)
        nextTurnButton = NextTurnButton(game: game)
        turnIndicator = TurnIndicator(game: game)
        notificationIndicator = NotificationIndicator(player: player)
        researchButton = ResearchButton(game: game)
        
        if view.safeAreaInsets.right > 0.0 {
            neAnchorPoint = CGPoint(x: (game.canvasSize.width / 2.0) - view.safeAreaInsets.right,
                                    y: (game.canvasSize.height / 2.0) - verticalPadding)
        }
        else {
            neAnchorPoint = CGPoint(x: (game.canvasSize.width / 2.0) - horizontalPadding,
                                    y: (game.canvasSize.height / 2.0) - verticalPadding)
        }
        
        if view.safeAreaInsets.left > 0.0 {
            nwAnchorPoint = CGPoint(x: -(game.canvasSize.width / 2.0) + view.safeAreaInsets.left,
                                    y: (game.canvasSize.height / 2.0) - verticalPadding)
        }
        else {
            nwAnchorPoint = CGPoint(x: -(game.canvasSize.width / 2.0) + horizontalPadding,
                                    y: (game.canvasSize.height / 2.0) - verticalPadding)
        }
        
        super.init()
        
        name = "camera"
        
        addChild(turnIndicator)
        addChild(notificationIndicator)
        addChild(nextTurnButton)
        // addChild(statsBar)
        addChild(researchButton)
        
        placeStatsBar()
        placeNotificationIndicator()
        placeTurnIndicator()
        placeNextTurnButton()
        placeResearchButton()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func placeNotificationIndicator() {
        let x = -(game.canvasSize.width / 2) + (notificationIndicator.size.width / 2) + horizontalPadding
        let y = -(game.canvasSize.height / 2) + (notificationIndicator.size.height) + 1.5*verticalPadding
        
        notificationIndicator.position = CGPoint(x: x, y: y)
        notificationIndicator.zPosition = Layer.hud + 1
    }
    
    private func placeTurnIndicator() {
        var x = 0.0
        var y = 0.0
        
        switch player.hud.turnIndicator {
        case HUDPosition.Northeast:
            x = neAnchorPoint.x - (turnIndicator.size.width / 2.0)
            y = neAnchorPoint.y - (turnIndicator.size.height / 2.0)
        case .Northwest:
            x = (game.canvasSize.width / 2) - (turnIndicator.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (turnIndicator.size.height) - verticalPadding
        case .West:
            x = (game.canvasSize.width / 2) - (turnIndicator.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (turnIndicator.size.height) - verticalPadding
        case .SouthWest:
            x = -(game.canvasSize.width / 2) + (turnIndicator.size.width / 2) + horizontalPadding
            y = -(game.canvasSize.height / 2) + (turnIndicator.size.height) + verticalPadding
        case .South:
            x = (game.canvasSize.width / 2) - (turnIndicator.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (turnIndicator.size.height) - verticalPadding
        case .Southeast:
            x = (game.canvasSize.width / 2) - (turnIndicator.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (turnIndicator.size.height) - verticalPadding
        case .East:
            x = (game.canvasSize.width / 2) - (turnIndicator.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (turnIndicator.size.height) - verticalPadding
        case .North:
            x = (game.canvasSize.width / 2) - (turnIndicator.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (turnIndicator.size.height) - verticalPadding
        }
        
        turnIndicator.zPosition = Layer.hud
        turnIndicator.position = CGPoint(x: x, y: y)
        
    }
    
    private func placeNextTurnButton() {
        var x = 0.0
        var y = 0.0
        
        let buttonWidth = nextTurnButton.size.width * nextTurnButton.xScale
        let buttonHeight = nextTurnButton.size.height * nextTurnButton.yScale
        
        switch player.hud.nextTurnButton {
        case HUDPosition.Northeast:
            if view.safeAreaInsets.right > 0.0 {
                x = (game.canvasSize.width / 2) - view.safeAreaInsets.right - (buttonWidth / 2.0)
            }
            else {
                x = (game.canvasSize.width / 2) - (buttonWidth / 2.0) - horizontalPadding
            }
            y = (game.canvasSize.height / 2.0) - (buttonHeight / 2.0) - verticalPadding
        case .Northwest:
            x = (game.canvasSize.width / 2) - (buttonWidth / 2.0) - horizontalPadding
            y = (game.canvasSize.height / 2) - (buttonHeight / 2.0) - 2.0 * verticalPadding
        case .West:
            x = (game.canvasSize.width / 2) - (buttonWidth / 2.0) - horizontalPadding
            y = (game.canvasSize.height / 2) - (buttonHeight / 2.0) - 2.0 * verticalPadding
        case .SouthWest:
            x = -(game.canvasSize.width / 2) + (buttonWidth / 2.0) + horizontalPadding
            y = -(game.canvasSize.height / 2) + (buttonHeight / 2.0) + verticalPadding
        case .South:
            x = (game.canvasSize.width / 2) - (buttonWidth / 2.0) - horizontalPadding
            y = (game.canvasSize.height / 2) - (buttonHeight / 2.0) - 2.0 * verticalPadding
        case .Southeast:
            if view.safeAreaInsets.right > 0.0 {
                x = (game.canvasSize.width / 2) - view.safeAreaInsets.right - (buttonWidth / 2.0)
            }
            else {
                x = (game.canvasSize.width / 2) - (buttonWidth / 2.0) - horizontalPadding
            }
            y = -(game.canvasSize.height / 2) + (buttonHeight / 2.0) + 2.0 * verticalPadding
        case .East:
            if view.safeAreaInsets.right > 0.0 {
                x = (game.canvasSize.width / 2) - view.safeAreaInsets.right - (buttonWidth / 2.0)
            }
            else {
                x = (game.canvasSize.width / 2) - (buttonWidth / 2.0) - horizontalPadding
            }
            y = (game.canvasSize.height / 2) - (buttonHeight / 2.0) - 2.0 * verticalPadding
        case .North:
            x = (game.canvasSize.width / 2) - (buttonWidth / 2.0) - horizontalPadding
            y = (game.canvasSize.height / 2) - (buttonHeight / 2.0) - 2.0 * verticalPadding
        }
        
        nextTurnButton.zPosition = Layer.hud
        nextTurnButton.position = CGPoint(x: x, y: y)
        
    }
    
    private func placeStatsBar() {
        var x = 0.0
        var y = 0.0
        
        let barWidth = statsBar.size.width * statsBar.xScale
        let barHeight = statsBar.size.height * statsBar.yScale
        
        switch player.hud.researchButton {
        case HUDPosition.Northeast:
            x = nwAnchorPoint.x + (barWidth / 2.0) + researchButton.size.width
            y = nwAnchorPoint.y - (barHeight / 2.0)
        case .Northwest:
            x = nwAnchorPoint.x + (barWidth / 2.0) + researchButton.size.width + horizontalPadding
            y = nwAnchorPoint.y - (barHeight / 2.0)
        case .West:
            x = -(game.canvasSize.width / 2) - (researchButton.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        case .SouthWest:
            x = -(game.canvasSize.width / 2) + (researchButton.size.width / 2) + horizontalPadding
            y = -(game.canvasSize.height / 2) + (researchButton.size.height) + verticalPadding
        case .South:
            x = (game.canvasSize.width / 2) - (researchButton.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        case .Southeast:
            if view.safeAreaInsets.right > 0.0 {
                x = (game.canvasSize.width / 2) - view.safeAreaInsets.right - (researchButton.size.width / 2.0)
            }
            else {
                x = (game.canvasSize.width / 2) - (researchButton.size.width / 2.0) - horizontalPadding
            }
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        case .East:
            x = (game.canvasSize.width / 2) - (researchButton.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        case .North:
            x = (game.canvasSize.width / 2) - (researchButton.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        }
        
        statsBar.zPosition = Layer.hud
        statsBar.position = CGPoint(x: x, y: y)
        
    }
    
    private func placeResearchButton() {
        var x = 0.0
        var y = 0.0
        
        let buttonWidth = researchButton.size.width * researchButton.xScale
        let buttonHeight = researchButton.size.height * researchButton.yScale
        
        switch player.hud.researchButton {
        case HUDPosition.Northeast:
            x = nwAnchorPoint.x - (buttonWidth / 2.0)
            y = nwAnchorPoint.y - (buttonHeight / 2.0)
        case .Northwest:
            x = nwAnchorPoint.x + (buttonWidth / 2.0)
            y = nwAnchorPoint.y - (buttonHeight / 2.0)
        case .West:
            x = -(game.canvasSize.width / 2) - (researchButton.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        case .SouthWest:
            x = -(game.canvasSize.width / 2) + (researchButton.size.width / 2) + horizontalPadding
            y = -(game.canvasSize.height / 2) + (researchButton.size.height) + verticalPadding
        case .South:
            x = (game.canvasSize.width / 2) - (researchButton.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        case .Southeast:
            if view.safeAreaInsets.right > 0.0 {
                x = (game.canvasSize.width / 2) - view.safeAreaInsets.right - (researchButton.size.width / 2.0)
            }
            else {
                x = (game.canvasSize.width / 2) - (researchButton.size.width / 2.0) - horizontalPadding
            }
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        case .East:
            x = (game.canvasSize.width / 2) - (researchButton.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        case .North:
            x = (game.canvasSize.width / 2) - (researchButton.size.width / 2) - horizontalPadding
            y = (game.canvasSize.height / 2) - (researchButton.size.height) - verticalPadding
        }
        
        researchButton.zPosition = Layer.hud
        researchButton.position = CGPoint(x: x, y: y)
        
    }
    
}
