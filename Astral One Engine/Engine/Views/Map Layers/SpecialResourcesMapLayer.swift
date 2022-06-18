import Foundation
import Combine
import SpriteKit

public class SpecialResourcesMapLayer {

    public init(player: Player, scene: SKScene, mapView: MapManager, tileSet: SKTileSet) {
        let node = SKTileMapNode(tileSet: tileSet,
                                 columns: player.map.width,
                                 rows: player.map.height,
                                 tileSize: Constants.tileSize)
        node.name = "Special resources map layer"
        node.zPosition = Layer.specialResources
        node.position = CGPoint.zero
        node.enableAutomapping = true
        node.isUserInteractionEnabled = false
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if let specialResource = tile.specialResource {
                        var assetName = ""
                        
                        if specialResource == SpecialResourceType.Buffalo {
                            assetName += "Buffalo"
                        }
                        else if specialResource == SpecialResourceType.Coal {
                            assetName += "Coal"
                        }
                        else if specialResource == SpecialResourceType.Fish {
                            assetName += "Fish"
                        }
                        else if specialResource == SpecialResourceType.Fruit {
                            assetName += "Fruit"
                        }
                        else if specialResource == SpecialResourceType.Furs {
                            assetName += "Furs"
                        }
                        else if specialResource == SpecialResourceType.Game {
                            assetName += "Game"
                        }
                        else if specialResource == SpecialResourceType.Gems {
                            assetName += "Gems"
                        }
                        else if specialResource == SpecialResourceType.Gold {
                            assetName += "Gold"
                        }
                        else if specialResource == SpecialResourceType.Iron {
                            assetName += "Iron"
                        }
                        else if specialResource == SpecialResourceType.Ivory {
                            assetName += "Ivory"
                        }
                        else if specialResource == SpecialResourceType.Oasis {
                            assetName += "Oasis"
                        }
                        else if specialResource == SpecialResourceType.Oil {
                            assetName += "Oil"
                        }
                        else if specialResource == SpecialResourceType.Peat {
                            assetName += "Peat"
                        }
                        else if specialResource == SpecialResourceType.Pheasant {
                            assetName += "Pheasant"
                        }
                        else if specialResource == SpecialResourceType.Silk {
                            assetName += "Silk"
                        }
                        else if specialResource == SpecialResourceType.Spice {
                            assetName += "Spice"
                        }
                        else if specialResource == SpecialResourceType.Whales {
                            assetName += "Whales"
                        }
                        else if specialResource == SpecialResourceType.Wheat {
                            assetName += "Wheat"
                        }
                        else if specialResource == SpecialResourceType.Wine {
                            assetName += "Wine"
                        }
                        
                        if let tileGroup = tileSet.tileGroups.first(where: { $0.name == assetName }) {
                            node.setTileGroup(tileGroup, forColumn: col, row: row)
                        }
                        else {
                            fatalError("Unable to find special resource \"\(assetName)\"")
                        }
                    }
                }
            }
        }
        
        scene.addChild(node)
    }
    
}
