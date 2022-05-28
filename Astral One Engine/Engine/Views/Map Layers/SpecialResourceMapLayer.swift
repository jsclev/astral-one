import Foundation
import Combine
import SpriteKit

public class SpecialResourceMapLayer {
    let tileSize = CGSize(width: 96, height: 48)

    public init(game: Game, scene: SKScene, mapView: MapView, tileSet: SKTileSet) {
        let node = SKTileMapNode(tileSet: tileSet,
                                 columns: game.map.width,
                                 rows: game.map.height,
                                 tileSize: tileSize)
        node.name = "tile stats"
        node.zPosition = Layer.tileStats
        node.position = CGPoint.zero
        node.enableAutomapping = true
        
        for row in 0..<game.map.height {
            for col in 0..<game.map.width {
                let tile = game.map.tile(at: Position(row: row, col: col))
                
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
//                        fatalError("Unable to find special resource \"\(assetName)\"")
                    }
                
                }
            }
        }
        
        scene.addChild(node)
        
//        for row in 0..<game.map.width {
//            for col in 0..<game.map.height {
//                let position = Position(row: row, col: col)
//                let tile = game.map.tile(at: position)
//
//                if let specialResource = tile.specialResource {
//                    let point = mapView.getCenterPointOf(position: position)
//                    let node = SpecialResourceNode(game: game, specialResource: specialResource)
//                    node.position = point
//                    node.zPosition = Layer.specialResources
//                    scene.addChild(node)
//                }
//            }
//        }
    }
    
}
