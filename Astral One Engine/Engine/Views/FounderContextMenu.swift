import Foundation
import SpriteKit
import Combine

public class CityCreatorMenu {
    private let parent: SKNode
    private let player: Player
    private let mapManager: MapManager
    private let menu = SKSpriteNode(imageNamed: "context-menu")
    private let menuItem1Node = SKSpriteNode(imageNamed: "create-city-icon")
    private let menuItem2Node = SKSpriteNode(imageNamed: "context-menu-item-2")
    private let menuItem3Node = SKSpriteNode(imageNamed: "context-menu-item-3")
    private let menuItem4Node = SKSpriteNode(imageNamed: "context-menu-item-4")
    private var cancellable = Set<AnyCancellable>()
    private let iconSize = 58.0
    
    public init(player: Player, parent: SKNode, mapManager: MapManager) {
        self.player = player
        self.parent = parent
        self.mapManager = mapManager
        
        menu.name = "Context Menu"
        menuItem1Node.name = "Found City Button"
        menuItem2Node.name = "Context Menu Item 2"
        menuItem3Node.name = "Context Menu Item 3"
        menuItem4Node.name = "Context Menu Item 4"
        
        menu.zPosition = Layer.contextMenu
        menuItem1Node.zPosition = Layer.contextMenuItem
        menuItem2Node.zPosition = Layer.contextMenuItem
        menuItem3Node.zPosition = Layer.contextMenuItem
        menuItem4Node.zPosition = Layer.contextMenuItem
        
        menu.position = CGPoint.zero
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
        
        menuItem1Node.isUserInteractionEnabled = true
        menu.isUserInteractionEnabled = true
        
        attachSubscribers()
        
        parent.addChild(menu)
    }
    
    private func attachSubscribers() {
        self.player.$selectedUnit
            .sink(receiveValue: { selectedUnit in
                if let unit = selectedUnit {
                    let unitPosition = self.mapManager.getCenterOf(position: unit.position)
                    self.menu.position = CGPoint(x: unitPosition.x - 1.0,
                                                 y: unitPosition.y + 3.0)
                    self.menu.isHidden = false
                }
                else {
                    self.menu.isHidden = true
                }
            })
            .store(in: &cancellable)
    }
    
}
