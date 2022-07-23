import Foundation
import Combine
import SpriteKit

public class UnitsMapLayer {
    private let game: Game
    private let player: Player
    private let scene: SKScene
    private let mapManager: MapManager
    private var cancellable = Set<AnyCancellable>()
    private let tileSet: SKTileSet
    private var localSettlers: [Settler] = []
    private var otherLocalSettlers: [Settler] = []
    private var unitNodes: [UnitNode] = []
    
    public init(game: Game,
                player: Player,
                scene: SKScene,
                mapManager: MapManager,
                tileSet: SKTileSet) {
        self.game = game
        self.player = player
        self.scene = scene
        self.mapManager = mapManager
        self.tileSet = tileSet
        
        attachSubscribers()
    }
    
    private func attachSubscribers() {
        player.$units
            .sink(receiveValue: { units in
                if let unit = units.last {
                    self.renderUnit(unit: unit)
                }
            })
            .store(in: &cancellable)
        
        player.$cityCreators
            .sink(receiveValue: { cityCreators in
                if cityCreators.count < self.localSettlers.count {
                    for settler in self.localSettlers {
                        var foundIt = false
                        for diff in cityCreators {
                            if diff.name == settler.name {
                                foundIt = true
                            }
                        }
                        
                        if !foundIt {
                            self.localSettlers.remove(at: self.localSettlers.count - 1)
                            
                            if let node = self.scene.childNode(withName: settler.name) {
                                node.removeFromParent()
                            }
                        }
                    }
                }
                else {
                    if let cityCreator = cityCreators.last {
                        self.renderUnit(unit: cityCreator)
                        self.localSettlers.append(cityCreator as! Settler)
                    }
                }
            })
            .store(in: &cancellable)
        
        player.$otherCityCreators
            .sink(receiveValue: { cityCreators in
                if cityCreators.count < self.otherLocalSettlers.count {
                    for settler in self.otherLocalSettlers {
                        var foundIt = false
                        for diff in cityCreators {
                            if diff.name == settler.name {
                                foundIt = true
                            }
                        }

                        if !foundIt {
                            self.otherLocalSettlers.remove(at: self.otherLocalSettlers.count - 1)

                            if let node = self.scene.childNode(withName: settler.name) {
                                node.removeFromParent()
                            }
                        }
                    }
                }
                else {
                    if let cityCreator = cityCreators.last {
                        self.renderUnit(unit: cityCreator)
                        self.otherLocalSettlers.append(cityCreator as! Settler)
                    }
                }
            })
            .store(in: &cancellable)
    }
    
    private func renderUnit(unit: Unit) {
        let unitPosition = mapManager.getCenterOf(position: unit.position)
//        let labelPosition = CGPoint(x: unitPosition.x - 5.0, y: unitPosition.y - 35.0)
        
        let unitNode = UnitNode(player: player, unit: unit, mapManager: mapManager)
        unitNode.position = unitPosition
        unitNode.zPosition = Layer.units
        unitNode.name = unit.name
        
        scene.addChild(unitNode)
        unit.node = unitNode
        

    }
}
