import Foundation
import Combine
import SpriteKit

public class CityView {
    private let player: Player
    private var cancellable = Set<AnyCancellable>()

    public init(player: Player, scene: SKScene, mapView: MapView) {
        self.player = player
        
        self.player.$cities
            .dropFirst()
            .sink(receiveValue: { cities in
                if let city = cities.last {
                    let point = mapView.getCenterPointOf(position: city.position)
                    
                    let node = CityNode(city: city)
                    node.position = point
                    node.zPosition = Layer.cities
                    scene.addChild(node)
                    
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
//                    label.position = CGPoint(x: point.x, y: point.y - 50)
                    label.text = text
                    label.zPosition = Layer.cityNames
                    
                    self.adjustLabelFontSizeToFitRect(labelNode: label,
                                                 rect: CGRect(x: point.x - 72, y: point.y - 70, width: 140, height: 60))
                    scene.addChild(label)
                    
                    // print("\(city.name) was added at \(city.position.row),\(city.position.col)")
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
}
