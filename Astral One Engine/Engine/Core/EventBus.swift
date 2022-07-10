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
    private var cmdIndex = 0
    private let cmds: [Command]
    
    private let advances = [
        "Pottery",
        "Alphabet",
        "Warrior Code",
        "Horseback Riding",
        "Bronze Working",
        "Masonry",
        "Ceremonial Burial",
        "Map Making",
        "Writing",
        "Code of Laws",
        "Mathematics",
        "Feudalism",
        "The Wheel",
        "Iron Working",
        "Currency",
        "Construction",
        "Mysticism",
        "Polytheism",
        "Seafaring",
        "Literacy",
        "Monarchy",
        "University",
        "Chivalry",
        "Engineering",
        "Bridge Building",
        "Trade",
        "Astronomy",
        "Philosophy",
        "Navigation",
        "The Republic",
        "Chemistry",
        "Leadership",
        "Invention",
        "Banking",
        "Medicine",
        "Theory of Gravity",
        "Monotheism"
    ]
    
    public init(game: Game, scene: SKScene, mapManager: MapManager) {
        self.game = game
        self.scene = scene
        self.mapManager = mapManager
        
        for player in game.players {
            player.map.revealAllTiles()
        }
        
        //game.placeInitialSettlers()
        
        cmds = game.db.commandDao.getCommands(game: game)
    }
    
    public func tap(recognizerLocation: CGPoint) {
        game.currentPlayer.clearNotification()
        
        let location = scene.convertPoint(fromView: recognizerLocation)
        let tile = mapManager.getTile(at: location)

        if let city = tile.city {
            let cmd = BuildBuildingCommand(player: game.currentPlayer,
                                           turn: game.getCurrentTurn(),
                                           ordinal: 1,
                                           cost: 1,
                                           city: city,
                                           buildingType: BuildingType.Barracks)
            print(cmd.execute(save: true).message)
            return
        }

        if cmds.count > 1 {
            if cmdIndex < cmds.count {
                let _ = cmds[cmdIndex].execute(save: false)
                cmdIndex += 1
                return
            }
            
            return
        }
        
        let touchedNodes = scene.nodes(at: location)
        
        for node in touchedNodes {
            if let name = node.name {
                // print("Name of node: \(name)")
                if name == "Next Turn" {
                    game.nextTurn()
                    return
                }
                else if name == "Research Button" {
//                    game.currentPlayer.add(advanceName: advances[advanceIndex])
//                    print("\(advances[advanceIndex]) researched.")
//
//                    advanceIndex += 1
                    return
                }
                else if name == "Found City Button" {
                    if let unit = game.currentPlayer.selectedUnit {
                        // Deselect the selected unit
                        let deselectUnitCmd = SelectUnitCommand(player: game.currentPlayer,
                                                                turn: game.getCurrentTurn(),
                                                                ordinal: 1,
                                                                node: scene,
                                                                mapManager: mapManager,
                                                                unit: unit)
                        let _ = deselectUnitCmd.execute(save: false)
                        
                        do {
                            let agent = try SettlerAgent.getAgent(aiPlayer: game.currentPlayer,
                                                                  settler: unit as! Settler)

                            if let position = try agent.getSettleCityPosition() {
                                let moveCmd = MoveUnitCommand(player: game.currentPlayer,
                                                              turn: game.getCurrentTurn(),
                                                              ordinal: 2,
                                                              unit: unit,
                                                              to: position)
                                let _ = moveCmd.execute(save: true)
                                // print(position)
                                // print(unit.position)

                                let cityCmd = CreateCityCommand(player: game.currentPlayer,
                                                                turn: game.getCurrentTurn(),
                                                                ordinal: 2,
                                                                cost: 1,
                                                                cityCreator: unit as! Settler,
                                                                cityName: "Chicago")
                                let _ = cityCmd.execute(save: true)
                                
                                if let city = cityCmd.city {
                                    let cityAgent = try CityAgent.getAgent(aiPlayer: game.currentPlayer,
                                                                           city: city)
                                    let cmd = cityAgent.getNextCommand()
                                    let _ = cmd.execute(save: true)
                                    
                                }
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                    
                    return
                }
            }
        }
        
        if let unit = mapManager.getUnit(on: tile) {
            let selectUnitCmd = SelectUnitCommand(player: game.currentPlayer,
                                                  turn: game.getCurrentTurn(),
                                                  ordinal: 1,
                                                  node: scene,
                                                  mapManager: mapManager,
                                                  unit: unit)
            let _ = selectUnitCmd.execute(save: false)
        }
        else {
            if let selectedUnit = game.currentPlayer.selectedUnit {
                let moveCmd = MoveUnitCommand(player: game.currentPlayer,
                                              turn: game.getCurrentTurn(),
                                              ordinal: 1,
                                              unit: selectedUnit,
                                              to: tile.position)
                let _ = moveCmd.execute(save: false)
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
        let _ = cmd.execute(save: true)
    }
    
    private func addEngineer(tile: Tile) {
        let player = game.currentPlayer
        
        if let city = player.getCity(at: tile.position) {
            let cmd = CreateEngineerCommand(player: player,
                                            turn: game.getCurrentTurn(),
                                            ordinal: 1,
                                            cost: 1,
                                            city: city)
            let _ = cmd.execute(save: false)
        }
    }
    
    private func addInitialSettler(player: AIPlayer, tile: Tile) {
//        let minRow = 2
//        let maxRow = player.map.height - 2
//        let minCol = 2
//        let maxCol = player.map.width - 2
//
//        var foundTile = false
//        var tile = player.map.tile(at: Position(row: 0, col: 0))
//
//        while !foundTile {
//            let randomRow = Int.random(in: minRow...maxRow)
//            let randomCol = Int.random(in: minCol...maxCol)
//
//            tile = player.map.tile(at: Position(row: randomRow, col: randomCol))
//
//            if tile.canCreateCity {
//                foundTile = true
//                print("Adding Settler to [\(randomRow), \(randomCol)]")
//            }
//        }
        
//        let cmd = CreateSettlerCommand(player: player,
//                                       turn: player.game.getCurrentTurn(),
//                                       ordinal: 1,
//                                       cost: 1,
//                                       tile: tile)
//        let _ = cmd.execute()
//
//        if let settler = player.cityCreators.last as? Settler {
//            do {
//
//            }
//            catch {
//                fatalError("\(error)")
//            }
//        }
        //print(player.cityCreators.last!.id)
        
        //        let settler1 = Settler(game: game,
        //                              player: player,
        //                              theme: game.theme,
        //                              name: "Settler",
        //                              position: tile.position)
        //        let settler2 = Settler(game: game,
        //                               player: player,
        //                               theme: game.theme,
        //                               name: "Settler2",
        //                               position: tile.position)
        
        //        player.add(cityCreator: settler1)
        //        player.add(cityCreator: settler2)
        
        //        let createCityCmd = CreateCityCommand(player: player,
        //                                              turn: player.game.getCurrentTurn(),
        //                                              ordinal: 1,
        //                                              cost: 0,
        //                                              cityCreator: settler1,
        //                                              cityName: "New York")
        // createCityCmd.execute()
    }
    
    private func addCity(settler: Settler, tile: Tile) {
        let player = game.currentPlayer
        
        let createCityCmd = CreateCityCommand(player: player,
                                              turn: game.getCurrentTurn(),
                                              ordinal: 1,
                                              cost: 0,
                                              cityCreator: settler,
                                              cityName: "New York-\(player.playerId)")
        let result = createCityCmd.execute(save: true)
        
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
