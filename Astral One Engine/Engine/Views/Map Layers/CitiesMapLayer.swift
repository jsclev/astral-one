import Foundation
import Combine
import SpriteKit

public class CitiesMapLayer {
    private let player: Player
    private let scene: SKScene
    private let mapView: MapManager
    private let citiesNode: SKTileMapNode
    private var cancellable = Set<AnyCancellable>()
    private let tileSet: SKTileSet

    public init(player: Player, scene: SKScene, mapView: MapManager, tileSet: SKTileSet) {
        self.player = player
        self.scene = scene
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
        
        self.player.map.$otherCities
            .sink(receiveValue: { cities in
                if let city = cities.last {
                    self.render(city: city)
                }
            })
            .store(in: &cancellable)
    }
    
    private func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, rect:CGRect) {
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
//        let scalingFactor = min(rect.width / labelNode.frame.width, rect.height / labelNode.frame.height)
        
//        labelNode.fontSize *= scalingFactor
        labelNode.fontSize = 18
        
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
            
            let label = SKLabelNode(fontNamed: "Arial Bold")
            var text = city.name
            
            if city.has(building: BuildingType.Barracks) {
                text += ", Barracks"
                label.numberOfLines += 1
            }
            
            if city.has(building: BuildingType.CityWalls) {
                text += ", Walls"
                label.numberOfLines += 1
            }
            
//            text += " (\(city.owner.name))"
            
            label.horizontalAlignmentMode = .center
            label.text = text
            label.zPosition = Layer.cityNames
            
            adjustLabelFontSizeToFitRect(labelNode: label,
                                         rect: CGRect(x: point.x - 80,
                                                      y: point.y - 55,
                                                      width: 160,
                                                      height: 57))
            var color = UIColor.white
            
            if city.owner.ordinal == 0 {
                color = UIColor.green
            }
            else if city.owner.ordinal == 1 {
                color = UIColor.red
            }
            else if city.owner.ordinal == 2 {
                color = UIColor.blue
            }
            else if city.owner.ordinal == 3 {
                color = UIColor.yellow
            }
            else if city.owner.ordinal == 4 {
                color = UIColor.cyan
            }
            
            label.fontColor = color
            
            scene.addChild(label)
        }
    }
}
