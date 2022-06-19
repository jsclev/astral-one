import Foundation
import Combine
import SpriteKit

public class CitiesMapLayer {
    private let player: Player
    private let mapView: MapManager
    private let citiesNode: SKTileMapNode
    private var cancellable = Set<AnyCancellable>()
    private let tileSet: SKTileSet

    public init(player: Player, scene: SKScene, mapView: MapManager, tileSet: SKTileSet) {
        self.player = player
        self.mapView = mapView
        self.tileSet = tileSet
        
        citiesNode = SKTileMapNode(tileSet: tileSet,
                                   columns: player.map.width,
                                   rows: player.map.height,
                                   tileSize: Constants.tileSize)
        citiesNode.name = "Cities map layer"
        citiesNode.zPosition = Layer.cities
        citiesNode.position = CGPoint.zero
        citiesNode.enableAutomapping = true
        citiesNode.isUserInteractionEnabled = false
        
        scene.addChild(citiesNode)
        
        for city in player.map.cities {
            render(city: city)
        }
        
        self.player.map.$cities
            .sink(receiveValue: { cities in
                if let city = cities.last {
                    self.render(city: city)
                }
            })
            .store(in: &cancellable)
    }
    
    private func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, rect:CGRect) {
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        let scalingFactor = min(rect.width / labelNode.frame.width, rect.height / labelNode.frame.height)
        
        // Change the fontSize.
        labelNode.fontSize *= scalingFactor
        
        // Optionally move the SKLabelNode to the center of the rectangle.
        labelNode.position = CGPoint(x: rect.midX, y: rect.midY - labelNode.frame.height / 2.0)
    }
    
    private func render(city: City) {
        if player.map.tile(at: city.position).visibility == Visibility.FullyRevealed {
            let point = mapView.getCenterOf(position: city.position)
            
            if let tileGroup = tileSet.tileGroups.first(where: { $0.name == "City" }) {
                // Make sure we are setting the tile on the correct layered terrain map
                citiesNode.setTileGroup(tileGroup,
                                        forColumn: city.position.col,
                                        row: city.position.row)
            }
            else {
                print("Unable to find tile group named \"City\"")
            }
            
            let label = SKLabelNode(fontNamed: "Arial")
            var text = city.name
            
            if city.has(building: BuildingType.Barracks) {
                text += ", Barracks"
                label.numberOfLines += 1
            }
            
            if city.has(building: BuildingType.CityWalls) {
                text += ", Walls"
                label.numberOfLines += 1
            }
            
            label.fontSize = 18
            label.horizontalAlignmentMode = .center
            label.text = text
            label.zPosition = Layer.cityNames
            
            adjustLabelFontSizeToFitRect(labelNode: label,
                                         rect: CGRect(x: point.x - 72, y: point.y - 70, width: 140, height: 60))
        }
    }
}
