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
    private var advanceIndex = 0
    
    private let advances = [
        AdvanceType.AdvancedFlight,
        AdvanceType.Alphabet,
        AdvanceType.AmphibiousWarfare,
        AdvanceType.Astronomy,
        AdvanceType.AtomicTheory,
        AdvanceType.Automobile,
        AdvanceType.Banking,
        AdvanceType.BridgeBuilding,
        AdvanceType.BronzeWorking,
        AdvanceType.CeremonialBurial,
        AdvanceType.Chemistry,
        AdvanceType.Chivalry,
        AdvanceType.CodeOfLaws,
        AdvanceType.CombinedArms,
        AdvanceType.Combustion,
        AdvanceType.Communism,
        AdvanceType.Computers,
        AdvanceType.Conscription,
        AdvanceType.Construction,
        AdvanceType.Corporation,
        AdvanceType.Currency,
        AdvanceType.Democracy,
        AdvanceType.Economics,
        AdvanceType.Electricity,
        AdvanceType.Electronics,
        AdvanceType.Engineering,
        AdvanceType.Environmentalism,
        AdvanceType.Error,
        AdvanceType.Espionage,
        AdvanceType.Explosives,
        AdvanceType.Feudalism,
        AdvanceType.Flight,
        AdvanceType.Fundamentalism,
        AdvanceType.FusionPower,
        AdvanceType.FutureTechnology,
        AdvanceType.GeneticEngineering,
        AdvanceType.GuerrillaWarfare,
        AdvanceType.Gunpowder,
        AdvanceType.HorsebackRiding,
        AdvanceType.Industrialization,
        AdvanceType.Invention,
        AdvanceType.IronWorking,
        AdvanceType.LaborUnion,
        AdvanceType.Laser,
        AdvanceType.Leadership,
        AdvanceType.Literacy,
        AdvanceType.MachineTools,
        AdvanceType.Magnetism,
        AdvanceType.MapMaking,
        AdvanceType.Masonry,
        AdvanceType.MassProduction,
        AdvanceType.Mathematics,
        AdvanceType.Medicine,
        AdvanceType.Metallurgy,
        AdvanceType.Miniaturization,
        AdvanceType.MobileWarfare,
        AdvanceType.Monarchy,
        AdvanceType.Monotheism,
        AdvanceType.Mysticism,
        AdvanceType.Navigation,
        AdvanceType.NuclearFission,
        AdvanceType.NuclearPower,
        AdvanceType.Philosophy,
        AdvanceType.Physics,
        AdvanceType.Plastics,
        AdvanceType.Polytheism,
        AdvanceType.Pottery,
        AdvanceType.Radio,
        AdvanceType.Railroad,
        AdvanceType.Recycling,
        AdvanceType.Refining,
        AdvanceType.Refrigeration,
        AdvanceType.Republic,
        AdvanceType.Robotics,
        AdvanceType.Rocketry,
        AdvanceType.Sanitation,
        AdvanceType.Seafaring,
        AdvanceType.SpaceFlight,
        AdvanceType.Stealth,
        AdvanceType.SteamEngine,
        AdvanceType.Steel,
        AdvanceType.Superconductor,
        AdvanceType.Tactics,
        AdvanceType.Theology,
        AdvanceType.TheoryOfGravity,
        AdvanceType.Trade,
        AdvanceType.University,
        AdvanceType.WarriorCode,
        AdvanceType.Wheel,
        AdvanceType.Writing
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
            let _ = BuildBuildingCommand(player: game.currentPlayer,
                                         turn: game.getCurrentTurn(),
                                         ordinal: 1,
                                         cost: 1,
                                         city: city,
                                         buildingType: BuildingType.Barracks)
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
                    let cmd = NextTurnCommand(player: game.currentPlayer,
                                              turn: game.getCurrentTurn(),
                                              ordinal: 1)
                    let _ = cmd.execute(save: true)
                    return
                }
                else if name == "Research Button" {
                    let cmd = ResearchAdvanceCommand(player: game.currentPlayer,
                                                     turn: game.getCurrentTurn(),
                                                     ordinal: 1,
                                                     cost: 1,
                                                     advanceType: advances[advanceIndex])
                    let _ = cmd.execute(save: true)
                    
                    advanceIndex += 1
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
