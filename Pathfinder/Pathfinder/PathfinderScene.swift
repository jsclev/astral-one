import SpriteKit
import AVFoundation
import GameplayKit
import Engine
import SwiftUI

enum PathfinderState {
    case initialized
    case settingStartPosition
    case settingStopPosition
    case calculatingPath
}

class PathfinderScene: SKScene {
    let game: Game
    var mapViewModel: MapViewModel
    var contextMenu: Engine.ContextMenu!
    var founderContextMenu: FounderContextMenu!
    var debug = true
    var gameCamera: PathfinderCamera!
    var cameraScale = 1.0
    var entityManager: EntityManager!
    var initialCameraScale = 1.0
    var pinchGestureRecognizer: UIPinchGestureRecognizer!
    let tilesetName: String = "Freeland Tile Set"
    let filename: String = "freeland"
    let mapIconsTilesetName: String = "Map Icons"
    let mapName = "terrain"
//    var tileset: SKTileSet!
    var mapIconsTileset: SKTileSet!
    var pathMap: SKTileMapNode
    var mapIcons: SKTileMapNode
    let tileSize: CGSize = CGSize(width: 96, height: 48)
    var state: PathfinderState = PathfinderState.initialized
    var startPosition = SIMD2<Int32>(0, 0)
    var endPosition = SIMD2<Int32>(0, 0)
    var mapView: MapView
    
    init(game: Game, mapViewModel: MapViewModel) {
        self.game = game
        self.mapViewModel = mapViewModel
        let tileset = SKTileSet(named: tilesetName)

        self.mapView = MapView(map: game.getMap(), tileset: tileset!)
        
        pathMap = SKTileMapNode(tileSet: tileset!,
                                columns: game.getMap().width,
                                rows: game.getMap().height,
                                tileSize: tileSize)
        pathMap.name = "terrain"
        pathMap.zPosition = Layer.unitPath
        pathMap.position = CGPoint.zero
        pathMap.enableAutomapping = true
        
        mapIconsTileset = SKTileSet(named: mapIconsTilesetName)
        mapIcons = SKTileMapNode(tileSet: mapIconsTileset,
                                 columns: game.getMap().width,
                                 rows: game.getMap().height,
                                 tileSize: tileSize)
        mapIcons.name = "map-icons"
        mapIcons.zPosition = Layer.unitPath2
        mapIcons.position = CGPoint.zero
        mapIcons.enableAutomapping = true
        

        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    @objc func tap(recognizer: UITapGestureRecognizer){
        if recognizer.state != .ended {
            return
        }
        
        let recognizorLocation = recognizer.location(in: recognizer.view!)
        let location = self.convertPoint(fromView: recognizorLocation)
        
        let touchedNodes = nodes(at: location)
        
//        for touchedNode in touchedNodes {
//            print("Touched node: \(touchedNode.name)")
//        }
        
        if !touchedNodes.isEmpty && touchedNodes[0].name == "set-start-position" {
            clearMapIcons()
            state = PathfinderState.settingStartPosition
            return
        }
        else if !touchedNodes.isEmpty && touchedNodes[0].name == "calculate-path" {
            state = PathfinderState.calculatingPath
            let path: [GKGridGraphNode] = [] //game.getMap().findPath(from: startPosition, to: endPosition)
//            showAIPath(path: path)
            return
        }
        
        let tappedRow = mapIcons.tileRowIndex(fromPosition: location)
        let tappedCol = mapIcons.tileColumnIndex(fromPosition: location)
        
        
        if state == PathfinderState.settingStartPosition {
            let tileGroup = mapIconsTileset.tileGroups.first { $0.name == "Start Icon" }
            startPosition.y = Int32(tappedCol)
            startPosition.x = Int32(tappedRow)
            mapIcons.setTileGroup(tileGroup, forColumn: tappedCol, row: tappedRow)
            state = PathfinderState.settingStopPosition
        }
        else if state == PathfinderState.settingStopPosition {
            let tileGroup = mapIconsTileset.tileGroups.first { $0.name == "Stop Icon" }
            endPosition.y = Int32(tappedCol)
            endPosition.x = Int32(tappedRow)
            mapIcons.setTileGroup(tileGroup, forColumn: tappedCol, row: tappedRow)
            state = PathfinderState.calculatingPath
        }
    }
    
    func clearMapIcons() {
        for row in 0..<mapIcons.numberOfRows {
            for col in 0..<mapIcons.numberOfColumns {
                if let _ = mapIcons.tileGroup(atColumn: col, row: row) {
                    mapIcons.setTileGroup(nil, forColumn: col, row: row)
                }
                
                if let _ = pathMap.tileGroup(atColumn: col, row: row) {
                    pathMap.setTileGroup(nil, forColumn: col, row: row)
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        gameCamera = PathfinderCamera(game: game)
        contextMenu = ContextMenu(game: game, parent: self, mapView: mapView)
        founderContextMenu = FounderContextMenu(game: game, parent: self, mapView: mapView)

        camera = gameCamera
        addChild(gameCamera)
        
        gameCamera.show()
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handleZoom))
        view.addGestureRecognizer(pinchGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)

        do {
            try game.importTiledMap(filename: filename)
            try game.load(gameId: 1)
            
            let tileset = SKTileSet(named: tilesetName)

            mapView = MapView(map: game.getMap(), tileset: tileset!)
            try mapView.setScene(scene: self)
        }
        catch {
            print(error)
        }
        
        game.processCommands(commands: game.db.commandDao.getCommands(gameId: 1))
        
        let player1 = Player(playerId: 1)

        let founder1 = Founder(playerId: 1, name: "Settler 1", row: 30, col: 30)
        let founder2 = Founder(playerId: 1, name: "Settler 2", row: 31, col: 31)
        let founder3 = Founder(playerId: 1, name: "Settler 3", row: 32, col: 32)
        
        let unit1 = Cavalry7(playerId: 1, name: "Tank", row: 28, col: 28)
        let unit2 = Naval4(playerId: 1, name: "Battleship", row: 28, col: 29)
        let unit3 = Cavalry3(playerId: 1, name: "Cavalry", row: 28, col: 30)
        
        let unit21 = Naval1(playerId: 1, name: "Trireme", row: 39, col: 19)
        let unit22 = Naval2(playerId: 1, name: "Caravel", row: 39, col: 20)
        let unit23 = Naval3(playerId: 1, name: "Galleon", row: 39, col: 21)
        let unit24 = Naval4(playerId: 1, name: "Frigate", row: 39, col: 22)
        let unit25 = Naval5(playerId: 1, name: "Ironclad", row: 39, col: 23)
        let unit26 = Naval6(playerId: 1, name: "Destroyer", row: 39, col: 24)
        let unit27 = Naval7(playerId: 1, name: "Cruiser", row: 39, col: 25)
        let unit28 = Naval8(playerId: 1, name: "Battleship", row: 39, col: 26)
        let unit29 = Naval9(playerId: 1, name: "AEGIS Cruiser", row: 39, col: 27)
        let transport = NavalTransport(playerId: 1, name: "Transport", row: 38, col: 19)
        let submarine = Submarine(playerId: 1, name: "Submarine", row: 38, col: 20)
        let carrier = AircraftCarrier(playerId: 1, name: "Carrier", row: 38, col: 21)
        
        let air1 = Air1(playerId: 1, name: "Bomber", row: 32, col: 30)
        let air2 = Air2(playerId: 1, name: "Fighter", row: 33, col: 30)
        let air3 = Air3(playerId: 1, name: "Stealth Figher", row: 34, col: 30)
        let air4 = Air4(playerId: 1, name: "Stealth Bomber", row: 35, col: 30)
        let air5 = Air5(playerId: 1, name: "Helicopter", row: 36, col: 30)

        let artillery1 = Artillery1(playerId: 1, name: "Catapult", row: 30, col: 34)
        let artillery2 = Artillery2(playerId: 1, name: "Cannon", row: 31, col: 34)
        let artillery3 = Artillery3(playerId: 1, name: "Artillery", row: 32, col: 34)
        let artillery4 = Artillery4(playerId: 1, name: "Howitzer", row: 33, col: 34)
        
        let unit51 = Infantry1(playerId: 1, name: "Warrior", row: 41, col: 19)
        let unit52 = Infantry2(playerId: 1, name: "Phalanx", row: 41, col: 20)
        let unit53 = Infantry3(playerId: 1, name: "Pikeman", row: 41, col: 21)
        let unit54 = Infantry4(playerId: 1, name: "Archer", row: 41, col: 22)
        let unit55 = Infantry5(playerId: 1, name: "Legion", row: 41, col: 23)
        let unit56 = Infantry6(playerId: 1, name: "Musketeer", row: 41, col: 24)
        let unit57 = Infantry7(playerId: 1, name: "Rifleman", row: 41, col: 25)
        let unit58 = Infantry8(playerId: 1, name: "Mechanized Infantry", row: 41, col: 26)

        let unit61 = Cavalry1(playerId: 1, name: "Horseman", row: 32, col: 29)
        let unit62 = Cavalry2(playerId: 1, name: "Chariot", row: 33, col: 29)
        let unit63 = Cavalry3(playerId: 1, name: "Elephant", row: 34, col: 29)
        let unit64 = Cavalry4(playerId: 1, name: "Knight", row: 35, col: 29)
        let unit65 = Cavalry5(playerId: 1, name: "Crusader", row: 36, col: 29)
        let unit66 = Cavalry6(playerId: 1, name: "Dragoon", row: 37, col: 29)
        let unit67 = Cavalry7(playerId: 1, name: "Cavalry", row: 38, col: 29)
        let unit68 = Cavalry8(playerId: 1, name: "Tank", row: 39, col: 29)

        player1.addFounder(founder: founder1)
        player1.addFounder(founder: founder2)
        player1.addFounder(founder: founder3)
        
        player1.addUnit(unit: unit1)
        player1.addUnit(unit: unit2)
        player1.addUnit(unit: unit3)
        
        player1.addUnit(unit: unit21)
        player1.addUnit(unit: unit22)
        player1.addUnit(unit: unit23)
        player1.addUnit(unit: unit24)
        player1.addUnit(unit: unit25)
        player1.addUnit(unit: unit26)
        player1.addUnit(unit: unit27)
        player1.addUnit(unit: unit28)
        player1.addUnit(unit: unit29)
        player1.addUnit(unit: submarine)
        player1.addUnit(unit: transport)
        player1.addUnit(unit: carrier)
        
        player1.addUnit(unit: air1)
        player1.addUnit(unit: air2)
        player1.addUnit(unit: air3)
        player1.addUnit(unit: air4)
        player1.addUnit(unit: air5)

        player1.addUnit(unit: artillery1)
        player1.addUnit(unit: artillery2)
        player1.addUnit(unit: artillery3)
        player1.addUnit(unit: artillery4)
        
        player1.addUnit(unit: unit51)
        player1.addUnit(unit: unit52)
        player1.addUnit(unit: unit53)
        player1.addUnit(unit: unit54)
        player1.addUnit(unit: unit55)
        player1.addUnit(unit: unit56)
        player1.addUnit(unit: unit57)
        player1.addUnit(unit: unit58)
        
        player1.addUnit(unit: unit61)
        player1.addUnit(unit: unit62)
        player1.addUnit(unit: unit63)
        player1.addUnit(unit: unit64)
        player1.addUnit(unit: unit65)
        player1.addUnit(unit: unit66)
        player1.addUnit(unit: unit67)
        player1.addUnit(unit: unit68)
        
        game.addPlayer(player: player1)

        for player in game.players {
            for founder in player.founders {
                let founderNode = FounderNode(game: game, founder: founder)
                founderNode.position = mapView.getCenterPoint(row: founder.row, col: founder.col)
                founderNode.zPosition = Layer.contextMenu
                addChild(founderNode)
            }
            
            for unit in player.units {
                let unitNode = UnitNode(game: game, unit: unit)
                unitNode.position = mapView.getCenterPoint(row: unit.row, col: unit.col)
                unitNode.zPosition = Layer.contextMenu
                addChild(unitNode)
            }
        }
        
        
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ss.SSS"
        print(string + formatter.string(from: date))
    }
    
    @objc func handleZoom(sender: UIPinchGestureRecognizer) {
        if (sender.state == .changed) {
            var scale = initialCameraScale + (1/sender.scale - 1) * initialCameraScale
            
            if scale >= 4.4 {
                scale = 4.4
            }
            
            gameCamera.setScale(scale)
            contextMenu.menu.setScale(scale)
        }
    }
    
//    func showAIPath(path: [GKGraphNode]) {
//        let tileGroupName = "Fog"
//
//        for node in path {
//            let theNode: GKGridGraphNode = node as! GKGridGraphNode
//
//            if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileGroupName }) {
//                print("[\(theNode.gridPosition.y),\(theNode.gridPosition.x)]")
//                pathMap.setTileGroup(tileGroup,
//                                     forColumn: Int(theNode.gridPosition.y),
//                                     row: Int(theNode.gridPosition.x))
//            }
//            else {
//                fatalError("\"\(tileGroupName)\" tile group not found in \"\(tilesetName)\" tile set.")
//            }
//        }
//    }
    
//    func showRandomAIPaths() {
//        //        print("About to calculate \(numPaths) paths: " + formatter.string(from: Date()))
//        let numPaths: Int = 1000
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm:ss.SSSS"
//
//        for _ in 0..<numPaths {
//            let from = SIMD2<Int32>(Int32.random(in: 0..<Int32(pathMap.numberOfRows)),
//                                    Int32.random(in: 0..<Int32(pathMap.numberOfColumns)))
//            let to = SIMD2<Int32>(Int32.random(in: 0..<Int32(pathMap.numberOfRows)),
//                                  Int32.random(in: 0..<Int32(pathMap.numberOfColumns)))
//            let path: [GKGridGraphNode] = [] //game.getMap().findPath(from: from, to: to)
//
//            for node in path {
//                let theNode: GKGridGraphNode = node as! GKGridGraphNode
//
//                if let tileGroup = tileset.tileGroups.first(where: { $0.name == "Fog"}) {
//                    pathMap.setTileGroup(tileGroup,
//                                         forColumn: Int(theNode.gridPosition.y),
//                                         row: Int(theNode.gridPosition.x))
//                }
//            }
//        }
//        //        print("Done calculating \(numPaths) paths: " + formatter.string(from: Date()))
//    }
}
