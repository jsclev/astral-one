import Foundation
import CoreGraphics
import UIKit
import SpriteKit

public class EventBus {
    private let game: Game
    private let scene: SKScene
    private let mapManager: MapManager
    private var tapCounter = 0
    
    public init(game: Game, scene: SKScene, mapManager: MapManager) {
        self.game = game
        self.scene = scene
        self.mapManager = mapManager
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
        
//        let touchedNodes = scene.nodes(at: location)
//
//        for node in touchedNodes {
//            if let name = node.name {
//                print("Touched \(name)")
//            }
//            else {
//                print("Touched unnamed node")
//            }
//        }
        let tile = mapManager.getTile(at: location)

        if let unit = mapManager.getSelectedUnit(location: location) {
            print("Tapped \(unit.name)(\(unit.id))")
            addCity(settler: unit as! Settler, tile: tile)

        }
        else {

        
            print("Tapped [\(tile.position.row), \(tile.position.col)]")
        
            addSettler(tile: tile)
        }
        
//        switch tapCounter {
//        case 0: addSettler(tile: tile)
//            break
//        case 1: addCity(tile: tile)
//            break
//        case 2: addEngineer(tile: tile)
//            break
//        case 3: addRoad(tile: tile)
//            break
//        default:
//            print("Should not have gotten here: \(tapCounter)")
//        }
//
//        if tapCounter == 3 {
//            tapCounter = 0
//        }
//        else {
//            tapCounter += 1
//        }
    }
    
    private func addSettler(tile: Tile) {
        let player = game.getCurrentPlayer()
        
        let settler = Settler(game: game,
                              player: player,
                              theme: game.theme,
                              name: "Settler-\(Int.random(in: 0..<500))",
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
    
    private func addCity(settler: Settler, tile: Tile) {
        let player = game.getCurrentPlayer()
        
        let createCityCmd = CreateCityCommand(player: player,
                                              turn: game.getCurrentTurn(),
                                              ordinal: 1,
                                              cost: 0,
                                              cityCreator: settler,
                                              cityName: "New York-\(player.playerId)")
        createCityCmd.execute()
        
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
                
                let randNum = Int.random(in: 3..<4)
                if randNum == 1 {
                    let createRoad = BuildRoadCommand(player: player,
                                                      turn: game.getCurrentTurn(),
                                                      ordinal: 1,
                                                      cost: 0,
                                                      builder: builder)
                    createRoad.execute()
                }
                else if randNum == 2 {
                    let createRailroad = BuildRailroadCommand(player: player,
                                                              turn: game.getCurrentTurn(),
                                                              ordinal: 1,
                                                              cost: 0,
                                                              builder: builder)
                    createRailroad.execute()
                }
                else if randNum == 3 {
                    let createFortress = BuildFortressCommand(player: player,
                                                              turn: game.getCurrentTurn(),
                                                              ordinal: 1,
                                                              cost: 0,
                                                              builder: builder)
                    createFortress.execute()
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
