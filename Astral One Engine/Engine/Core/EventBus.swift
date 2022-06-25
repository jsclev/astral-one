import Foundation
import CoreGraphics
import UIKit
import SpriteKit
import Combine

public class EventBus {
    private let game: Game
    private let scene: SKScene
    private let mapManager: MapManager
    private var cancellable = Set<AnyCancellable>()

    
    public init(game: Game, scene: SKScene, mapManager: MapManager) {
        self.game = game
        self.scene = scene
        self.mapManager = mapManager
    }
    
    public func tap(recognizer: UITapGestureRecognizer){
        // print("ran......")
        if recognizer.state != .ended {
            if recognizer.state == .began {
                print("removing action")
                scene.camera?.removeAction(forKey: "map-pan-momentum")
            }
            return
        }
        
        game.currentPlayer.clearNotification()
        
        let recognizorLocation = recognizer.location(in: recognizer.view!)
        let location = scene.convertPoint(fromView: recognizorLocation)
        
        for p in game.players {
            p.map.revealAllTiles()
        }
        
        let touchedNodes = scene.nodes(at: location)

        for node in touchedNodes {
            if let name = node.name {
//                print("Name of node: \(name)")
                if name == "Next Turn" {
                    game.nextTurn()
                    return
                }
                else if name == "Found City Button" {
                    if let unit = game.currentPlayer.selectedUnit {
                        let tile = game.currentPlayer.map.tile(at: unit.position)
                        let selectUnitCmd = SelectUnitCommand(player: game.currentPlayer,
                                                              turn: game.getCurrentTurn(),
                                                              ordinal: 1,
                                                              node: scene,
                                                              mapManager: mapManager,
                                                              unit: unit)
                        let _ = selectUnitCmd.execute()
                        addCity(settler: unit as! Settler, tile: tile)
                    }
                    
                    return
                }
            }
        }
        
        let tile = mapManager.getTile(at: location)

        if let unit = mapManager.getUnit(on: tile) {
            let selectUnitCmd = SelectUnitCommand(player: game.currentPlayer,
                                                  turn: game.getCurrentTurn(),
                                                  ordinal: 1,
                                                  node: scene,
                                                  mapManager: mapManager,
                                                  unit: unit)
            let _ = selectUnitCmd.execute()
        }
        else {
            if let selectedUnit = game.currentPlayer.selectedUnit {
                let moveCmd = MoveUnitCommand(player: game.currentPlayer,
                                              turn: game.getCurrentTurn(),
                                              ordinal: 1,
                                              mapManager: mapManager,
                                              unit: selectedUnit,
                                              to: tile.position)
                let _ = moveCmd.execute()
            }
            else {
                addSettler(tile: tile)
            }
        }
    }
    
    private func addSettler(tile: Tile) {
        let cmd = CreateSettlerCommand(player: game.currentPlayer,
                                       turn: game.getCurrentTurn(),
                                       ordinal: 1,
                                       cost: 1,
                                       tile: tile)
        let _ = cmd.execute()
    }
    
    private func addEngineer(tile: Tile) {
        let player = game.currentPlayer
        
        if let city = player.getCity(at: tile.position) {
            let cmd = CreateEngineerCommand(player: player,
                                            turn: game.getCurrentTurn(),
                                            ordinal: 1,
                                            cost: 1,
                                            city: city)
            let _ = cmd.execute()
        }
    }
    
    private func addCity(settler: Settler, tile: Tile) {
        let player = game.currentPlayer
        
        let createCityCmd = CreateCityCommand(player: player,
                                              turn: game.getCurrentTurn(),
                                              ordinal: 1,
                                              cost: 0,
                                              cityCreator: settler,
                                              cityName: "New York-\(player.playerId)")
        let result = createCityCmd.execute()
        
        if result.status != CommandStatus.Ok {
            print(player.playerId)

            player.setNotification(notification: result.message)
        }
        
//        do {
//            let agent = try SettlerAgent.getAgent(aiPlayer: player as! AIPlayer,
//                                                  settler: settler)
//            if let position = try agent.getSettleCityPosition() {
//                print("Moving Settler to position [\(position.row), \(position.col)]")
//                let moveCmd = MoveUnitCommand(player: player,
//                                              type: CommandType(id: 1, name: ""),
//                                              turn: game.getCurrentTurn(),
//                                              ordinal: 1,
//                                              unit: settler,
//                                              to: position)
//                moveCmd.execute()
//
//                let createCityCmd = CreateCityCommand(player: player,
//                                                      turn: game.getCurrentTurn(),
//                                                      ordinal: 1,
//                                                      cost: 0,
//                                                      cityCreator: settler,
//                                                      cityName: "New York-\(player.playerId)")
//                createCityCmd.execute()
//            }
//            else {
//                print("No where to settle city")
//            }
//        }
//        catch {
//            print(error)
//        }
    }
    
//    private func addRoad(tile: Tile) {
//        let player = game.getCurrentPlayer()
//
//        for unit in player.units {
//            if unit.position == tile.position && unit.name == "Engineer" {
//                let builder = unit as! Builder
//
//                let move1 = MoveUnitCommand(player: player,
//                                            turn: game.getCurrentTurn(),
//                                            ordinal: 1,
//                                            unit: builder,
//                                            to: Position(row: unit.position.row + 1,
//                                                         col: unit.position.col + 1))
//                move1.execute()
//
//                let randNum = Int.random(in: 3..<4)
//                if randNum == 1 {
//                    let createRoad = BuildRoadCommand(player: player,
//                                                      turn: game.getCurrentTurn(),
//                                                      ordinal: 1,
//                                                      cost: 0,
//                                                      builder: builder)
//                    createRoad.execute()
//                }
//                else if randNum == 2 {
//                    let createRailroad = BuildRailroadCommand(player: player,
//                                                              turn: game.getCurrentTurn(),
//                                                              ordinal: 1,
//                                                              cost: 0,
//                                                              builder: builder)
//                    createRailroad.execute()
//                }
//                else if randNum == 3 {
//                    let createFortress = BuildFortressCommand(player: player,
//                                                              turn: game.getCurrentTurn(),
//                                                              ordinal: 1,
//                                                              cost: 0,
//                                                              builder: builder)
//                    createFortress.execute()
//                }
//
//                let move2 = MoveUnitCommand(player: player,
//                                            turn: game.getCurrentTurn(),
//                                            ordinal: 1,
//                                            unit: builder,
//                                            to: Position(row: Int.random(in: 0..<player.map.height),
//                                                         col: Int.random(in: 0..<player.map.width)))
//                move2.execute()
//            }
//        }
//    }
}
