import Foundation
import SpriteKit
import Combine

public class ContextMenu {
    private let parent: SKNode
    private let game: Game
    private let mapView: MapManager
    private var cancellable = Set<AnyCancellable>()

    public let menu = SKSpriteNode(imageNamed: "context-menu")

    private let menuItem1Node = SKSpriteNode(imageNamed: "context-menu-item-1")
    private let menuItem2Node = SKSpriteNode(imageNamed: "context-menu-item-2")
    private let menuItem3Node = SKSpriteNode(imageNamed: "context-menu-item-3")
    private let menuItem4Node = SKSpriteNode(imageNamed: "context-menu-item-4")
    private let menuItem5Node = SKSpriteNode(imageNamed: "context-menu-item-5")
    private let menuItem6Node = SKSpriteNode(imageNamed: "context-menu-item-6")
    private let menuItem7Node = SKSpriteNode(imageNamed: "context-menu-item-7")
    private let menuItem8Node = SKSpriteNode(imageNamed: "context-menu-item-8")
    
    let iconSize = 58.0

    public init(game: Game, parent: SKNode, mapView: MapManager) {
        self.parent = parent
        self.game = game
        self.mapView = mapView
        
        menu.name = "Context Menu"
        menuItem1Node.name = "Context Menu Item 1"
        menuItem2Node.name = "Context Menu Item 2"
        menuItem3Node.name = "Context Menu Item 3"
        menuItem4Node.name = "Context Menu Item 4"
        menuItem5Node.name = "Context Menu Item 5"
        menuItem6Node.name = "Context Menu Item 6"
        menuItem7Node.name = "Context Menu Item 7"
        menuItem8Node.name = "Context Menu Item 8"
        
        menu.zPosition = Layer.contextMenu
        menuItem1Node.zPosition = Layer.contextMenuItem
        menuItem2Node.zPosition = Layer.contextMenuItem
        menuItem3Node.zPosition = Layer.contextMenuItem
        menuItem4Node.zPosition = Layer.contextMenuItem
        menuItem5Node.zPosition = Layer.contextMenuItem
        menuItem6Node.zPosition = Layer.contextMenuItem
        menuItem7Node.zPosition = Layer.contextMenuItem
        menuItem8Node.zPosition = Layer.contextMenuItem
        
        menu.position = CGPoint(x: 0, y: 0)
        menuItem1Node.position = CGPoint(x: 0, y: 75)
        menuItem2Node.position = CGPoint(x: 55, y: 57)
        menuItem3Node.position = CGPoint(x: 75, y: 0)
        menuItem4Node.position = CGPoint(x: 55, y: -57)
        menuItem5Node.position = CGPoint(x: 0, y: -75)
        menuItem6Node.position = CGPoint(x: -55, y: -57)
        menuItem7Node.position = CGPoint(x: -75, y: 0)
        menuItem8Node.position = CGPoint(x: -55, y: 57)
        
        menuItem1Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem2Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem3Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem4Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem5Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem6Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem7Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem8Node.size = CGSize(width: iconSize, height: iconSize)

        menu.addChild(menuItem1Node)
        menu.addChild(menuItem2Node)
        menu.addChild(menuItem3Node)
        menu.addChild(menuItem4Node)
        menu.addChild(menuItem5Node)
        menu.addChild(menuItem6Node)
        menu.addChild(menuItem7Node)
        menu.addChild(menuItem8Node)
        
        menu.isHidden = true
        parent.addChild(menu)

        self.game.$selectedMapPosition
            .dropFirst()
            .sink(receiveValue: { position in
                self.menu.position = self.mapView.getCenterPointOf(position: position)
                self.menu.isHidden = !self.menu.isHidden
            })
            .store(in: &cancellable)
    }

}
