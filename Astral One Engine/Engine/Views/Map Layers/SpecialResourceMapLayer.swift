import Foundation
import Combine
import SpriteKit

public class SpecialResourceMapLayer {

    public init(player: Player, scene: SKScene, mapView: MapView, tileSet: SKTileSet) {
        let node = SKTileMapNode(tileSet: tileSet,
                                 columns: player.map.width,
                                 rows: player.map.height,
                                 tileSize: Constants.tileSize)
        node.name = "tile stats"
        node.zPosition = Layer.tileStats
        node.position = CGPoint.zero
        node.enableAutomapping = true
        
        for row in 0..<player.map.height {
            for col in 0..<player.map.width {
                let tile = player.map.tile(at: Position(row: row, col: col))
                
                if tile.visibility == Visibility.FullyRevealed {
                    if let specialResource = tile.specialResource {
                        var assetName = ""
                        
                        if specialResource == SpecialResource.Buffalo {
                            assetName += "Buffalo"
                        }
                        else if specialResource == SpecialResource.Coal {
                            assetName += "Coal"
                        }
                        else if specialResource == SpecialResource.Fish {
                            assetName += "Fish"
                        }
                        else if specialResource == SpecialResource.Fruit {
                            assetName += "Fruit"
                        }
                        else if specialResource == SpecialResource.Furs {
                            assetName += "Furs"
                        }
                        else if specialResource == SpecialResource.Game {
                            assetName += "Game"
                        }
                        else if specialResource == SpecialResource.Gems {
                            assetName += "Gems"
                        }
                        else if specialResource == SpecialResource.Gold {
                            assetName += "Gold"
                        }
                        else if specialResource == SpecialResource.Iron {
                            assetName += "Iron"
                        }
                        else if specialResource == SpecialResource.Ivory {
                            assetName += "Ivory"
                        }
                        else if specialResource == SpecialResource.Oasis {
                            assetName += "Oasis"
                        }
                        else if specialResource == SpecialResource.Oil {
                            assetName += "Oil"
                        }
                        else if specialResource == SpecialResource.Peat {
                            assetName += "Peat"
                        }
                        else if specialResource == SpecialResource.Pheasant {
                            assetName += "Pheasant"
                        }
                        else if specialResource == SpecialResource.Silk {
                            assetName += "Silk"
                        }
                        else if specialResource == SpecialResource.Spice {
                            assetName += "Spice"
                        }
                        else if specialResource == SpecialResource.Whales {
                            assetName += "Whales"
                        }
                        else if specialResource == SpecialResource.Wheat {
                            assetName += "Wheat"
                        }
                        else if specialResource == SpecialResource.Wine {
                            assetName += "Wine"
                        }
                        
                        if let tileGroup = tileSet.tileGroups.first(where: { $0.name == assetName }) {
                            // Make sure we are setting the tile on the correct layered terrain map
                            node.setTileGroup(tileGroup, forColumn: col, row: row)
                        }
                        else {
                            print("Unable to find special resource \"\(assetName)\"")
                        }
                    }
                }
            }
        }
        
        scene.addChild(node)
    }
    
}
