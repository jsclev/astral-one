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
                    label.fontSize = 20
                    label.horizontalAlignmentMode = .center
                    label.position = CGPoint(x: point.x, y: point.y - 50)
                    label.text = city.name
                    label.zPosition = Layer.cityNames
                    scene.addChild(label)
                    
                    print("\(city.name) was added at \(city.position.row),\(city.position.col)")
                }
            })
            .store(in: &cancellable)
    }
}
