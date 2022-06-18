import Foundation
import SpriteKit
import Combine

public class FounderContextMenu {
    private let parent: SKNode
    private let game: Game
    private let mapView: MapManager
    private var cancellable = Set<AnyCancellable>()
    
    public let menu = SKSpriteNode(imageNamed: "context-menu")
    private let menuItem1Node = SKSpriteNode(imageNamed: "context-menu-item-1")
    private let menuItem2Node = SKSpriteNode(imageNamed: "context-menu-item-2")
    private let menuItem3Node = SKSpriteNode(imageNamed: "context-menu-item-3")
    private let menuItem4Node = SKSpriteNode(imageNamed: "context-menu-item-4")
    
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
        
        menu.zPosition = Layer.contextMenu
        menuItem1Node.zPosition = Layer.contextMenuItem
        menuItem2Node.zPosition = Layer.contextMenuItem
        menuItem3Node.zPosition = Layer.contextMenuItem
        menuItem4Node.zPosition = Layer.contextMenuItem
        
        menu.position = CGPoint(x: 0, y: 0)
        menuItem1Node.position = CGPoint(x: 55, y: 55)
        menuItem2Node.position = CGPoint(x: 55, y: -55)
        menuItem3Node.position = CGPoint(x: -55, y: -55)
        menuItem4Node.position = CGPoint(x: -55, y: 55)
        
        menuItem1Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem2Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem3Node.size = CGSize(width: iconSize, height: iconSize)
        menuItem4Node.size = CGSize(width: iconSize, height: iconSize)
        
        menu.addChild(menuItem1Node)
        menu.addChild(menuItem2Node)
        menu.addChild(menuItem3Node)
        menu.addChild(menuItem4Node)
        
        menu.isHidden = true
        parent.addChild(menu)
        
        self.game.$selectedCityCreator
            .dropFirst()
            .sink(receiveValue: { founder in
                if let f = founder {
                    print("\(f.name) touched!")
                }
                else {
                    print("An unnamed city creator node touched.")
                }

                self.menu.isHidden = !self.menu.isHidden
            })
            .store(in: &cancellable)
    }
    
}
