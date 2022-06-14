import Foundation
import CoreGraphics
import UIKit
import SpriteKit

public class EventBus {
    private let game: Game
    private let scene: SKScene
    private let mapView: MapView
    
    public init(game: Game, scene: SKScene, mapView: MapView) {
        self.game = game
        self.scene = scene
        self.mapView = mapView
    }
    
    public func tap(recognizer: UITapGestureRecognizer){
        if recognizer.state != .ended {
            return
        }
        
        let recognizorLocation = recognizer.location(in: recognizer.view!)
        let location = scene.convertPoint(fromView: recognizorLocation)
        
        let tile = mapView.tap(location: location)
        
        print("Tapped [\(tile.position.row), \(tile.position.col)]")
        
        if let city = tile.city {
            print("\(city.name) tapped")
        }
        
        let player = game.getCurrentPlayer()
        let units = player.cityCreators
        var foundUnitsAtLocation = false
        
        for unit in units {
            if unit.position == tile.position {
                foundUnitsAtLocation = true
                
                print("Found unit {id: \(unit.id), \"\(unit.name)\"} at [\(unit.position.row), \(unit.position.col)]")
                
                if unit.name == "Settler" {
                    do {
                        let agent = try SettlerAgent.getAgent(aiPlayer: player as! AIPlayer,
                                                              settler: unit as! Settler)
                        if let position = try agent.getSettleCityPosition() {
                            print("Moving Settler to position [\(position.row), \(position.col)]")
                            let moveCmd = MoveUnitCommand(player: player,
                                                          type: CommandType(id: 1, name: ""),
                                                          turn: player.game.getCurrentTurn(),
                                                          ordinal: 1,
                                                          unit: unit,
                                                          to: position)
                            moveCmd.execute()
                            
                            let createCityCmd = CreateCityCommand(player: player,
                                                                  type: CommandType(id: 0, name: ""),
                                                                  turn: Turn(id: 1,
                                                                             year: -4000,
                                                                             ordinal: 1,
                                                                             displayText: "4000 B.C."),
                                                                  ordinal: 1,
                                                                  cost: 0,
                                                                  cityCreator: unit,
                                                                  cityName: "New York-\(unit.id)")
                            createCityCmd.execute()
                            print("Build this city on rock and roll.")
                        }
                        else {
                            print("No where to settle city")
                        }
                    }
                    catch {
                        print("hello")
                        print(error)
                    }
                }
            }
        }
        
        if !foundUnitsAtLocation && tile.canBuildCity() {
            let settler = Settler(game: game,
                                  player: player,
                                  theme: game.theme,
                                  name: "Settler",
                                  position: tile.position)
            
            player.add(cityCreator: settler)
        }
        
    }
}
