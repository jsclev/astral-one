import Foundation
import CoreGraphics
import UIKit
import SpriteKit

public class EventBus {
    private let game: Game
    private let scene: SKScene
    private let mapView: MapView
    private var tapCounter = 0
    
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
        
        for p in game.players {
            p.map.revealAllTiles()
        }
        
        let tile = mapView.tap(location: location)
        
        print("Tapped [\(tile.position.row), \(tile.position.col)]")
        
        
        switch tapCounter {
        case 0: addSettler(tile: tile)
            break
        case 1: addCity(tile: tile)
            break
        case 2: addEngineer(tile: tile)
            break
        case 3: addRoad(tile: tile)
            break
        default:
            print("Should not have gotten here: \(tapCounter)")
        }
        
        if tapCounter == 3 {
            tapCounter = 0
        }
        else {
            tapCounter += 1
        }
    }
    
    private func addSettler(tile: Tile) {
        let player = game.getCurrentPlayer()
        
        let settler = Settler(game: game,
                              player: player,
                              theme: game.theme,
                              name: "Settler",
                              position: tile.position)
        
        player.add(cityCreator: settler)
    }
    
    private func addEngineer(tile: Tile) {
        let player = game.getCurrentPlayer()
        
        if let city = player.getCity(at: tile.position) {
            let cmd = CreateEngineerCommand(player: player,
                                            turn: game.getCurrentTurn(),
                                            ordinal: 1,
                                            cost: 1,
                                            city: city)
            cmd.execute()
        }
    }
    
    private func addCity(tile: Tile) {
        let player = game.getCurrentPlayer()
        
        let units = player.cityCreators
        
        for unit in units {
            if unit.position == tile.position {
                print("Found unit {id: \(unit.id), \"\(unit.name)\"} at [\(unit.position.row), \(unit.position.col)]")
                
                if unit.name == "Settler" {
                    do {
                        let agent = try SettlerAgent.getAgent(aiPlayer: player as! AIPlayer,
                                                              settler: unit as! Settler)
                        if let position = try agent.getSettleCityPosition() {
                            print("Moving Settler to position [\(position.row), \(position.col)]")
                            let moveCmd = MoveUnitCommand(player: player,
                                                          type: CommandType(id: 1, name: ""),
                                                          turn: game.getCurrentTurn(),
                                                          ordinal: 1,
                                                          unit: unit,
                                                          to: position)
                            moveCmd.execute()
                            
                            let createCityCmd = CreateCityCommand(player: player,
                                                                  turn: game.getCurrentTurn(),
                                                                  ordinal: 1,
                                                                  cost: 0,
                                                                  cityCreator: unit,
                                                                  cityName: "New York-\(player.playerId)")
                            createCityCmd.execute()
                        }
                        else {
                            print("No where to settle city")
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    private func addRoad(tile: Tile) {
        let player = game.getCurrentPlayer()
        
        for unit in player.units {
            if unit.position == tile.position && unit.name == "Engineer" {
                let builder = unit as! Builder
                
                let move1 = MoveUnitCommand(player: player,
                                            type: CommandType(id: 1, name: ""),
                                            turn: game.getCurrentTurn(),
                                            ordinal: 1,
                                            unit: builder,
                                            to: Position(row: unit.position.row + 1,
                                                         col: unit.position.col + 1))
                move1.execute()
                
                if Int.random(in: 0..<10) % 2 == 0 {
                    let createRoad = BuildRoadCommand(player: player,
                                                      turn: game.getCurrentTurn(),
                                                      ordinal: 1,
                                                      cost: 0,
                                                      builder: builder)
                    createRoad.execute()
                }
                else {
                    let createRailroad = BuildRailroadCommand(player: player,
                                                              turn: game.getCurrentTurn(),
                                                              ordinal: 1,
                                                              cost: 0,
                                                              builder: builder)
                    createRailroad.execute()
                }
                
                let move2 = MoveUnitCommand(player: player,
                                            type: CommandType(id: 1, name: ""),
                                            turn: game.getCurrentTurn(),
                                            ordinal: 1,
                                            unit: builder,
                                            to: Position(row: Int.random(in: 0..<player.map.height),
                                                         col: Int.random(in: 0..<player.map.width)))
                move2.execute()
            }
        }
    }
}
