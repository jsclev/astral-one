import SpriteKit
import AVFoundation
import GameplayKit
import Astral_One_Engine

class GameScene: SKScene {
    private let background: SKSpriteNode
    private var isLevelOver = false
    private var didCutVine = false
    var mapViewModel: MapViewModel
    var debug = true
    var gameCamera: GameCamera!
    var cameraScale = 1.0
    var entityManager: EntityManager!
    var initialCameraScale = 1.0
    var pinchGestureRecognizer: UIPinchGestureRecognizer!
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        
        background = SKSpriteNode(texture: mapViewModel.texture3)
        background.name = "background"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.base
        
        super.init(size: UIScreen.main.bounds.size)
        self.scaleMode = .fill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    @objc func tap(sender: UITapGestureRecognizer){

    }
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager(scene: self)
        gameCamera = GameCamera(entityManager)
        
        camera = gameCamera
        addChild(gameCamera)
        
        gameCamera.show()
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handleZoom))
        view.addGestureRecognizer(pinchGestureRecognizer)
        
        let tilesetParser = TiledTilesetParser("civ2")
        let tileset = tilesetParser.parse()
        
        let mapParser = TiledMapParser(tileset: tileset, filename: "civ2")
        let map = mapParser.parse()
        map.bake()
        
        renderMap(map: map)
        
        print(gameCamera.position)
        
        //        gameCamera.position = CGPoint(x: (mapSize.width / 2.0),
        //                                      y: (mapSize.height / 2.0))
        //        gameCamera.position = CGPoint(x: 1194.662 / 2.0,
        //                                      y: 1621.327 / 3.0)
        print(gameCamera.position)
    }
    
    @objc func handleZoom(sender: UIPinchGestureRecognizer) {
        var anchorPoint: CGPoint = sender.location(in: sender.view)
        anchorPoint = convertPoint(fromView: anchorPoint)
        
        if (sender.state == .began) {
            //            print("zoom started")
            self.initialCameraScale = gameCamera.xScale
        }
        else if (sender.state == .changed) {
            //            print("zooming...scale is \(sender.scale)")
            //            var anchorPointInMySkNode: CGPoint = convertPoint(fromView: anchorPoint)
            
            var scale = initialCameraScale + (1/sender.scale - 1) * initialCameraScale
            if scale < 0.4 {
                scale = 0.4
            }
            gameCamera.setScale(scale)
            print(gameCamera.xScale)
            //            sender.scale = 1.0
            //
            //            [_mySkNode setScale:(_mySkNode.xScale * recognizer.scale)];
            //
            //            CGPoint mySkNodeAnchorPointInScene = [self convertPoint:anchorPointInMySkNode fromNode:_mySkNode];
            //            CGPoint translationOfAnchorInScene = CGPointSubtract(anchorPoint, mySkNodeAnchorPointInScene);
            //
            //            _mySkNode.position = CGPointAdd(_mySkNode.position, translationOfAnchorInScene);
            //
            //            recognizer.scale = 1.0;
        }
        else if (sender.state == .ended) {
            //            print("zoom ended, gameCamera scale is \(self.sca.scale)")
        }
    }
    
    func toggleDebug() {
        
    }
    
    private func renderMap(map: Map) {
        let tilesetName = "Civ 2 Tile Set"
        guard let tileSet = SKTileSet(named: tilesetName) else {
            fatalError("Tileset \"\(tilesetName)\" was not found in app bundle.")
        }
        
        let tileSize = CGSize(width: 96, height: 48)
        let rows = 100
        let cols = 100
        
        let terrainMap = SKTileMapNode(tileSet: tileSet,
                                       columns: cols,
                                       rows: rows,
                                       tileSize: tileSize)
        terrainMap.zPosition = Layer.terrain
        terrainMap.position = CGPoint.zero
        terrainMap.enableAutomapping = true
        
        let unitsMap = SKTileMapNode(tileSet: tileSet,
                                     columns: cols,
                                     rows: rows,
                                     tileSize: tileSize)
        unitsMap.zPosition = Layer.units
        unitsMap.position = CGPoint.zero
        unitsMap.enableAutomapping = true
        
        //        guard let grassTile = tileGroups.first(where: {$0.name == "Grass"}) else {
        //            fatalError("No Grass tile definition found")
        //        }
        
        let grassTiles = tileSet.tileGroups.first { $0.name == "Grass"}
        //        let sandTiles = tileSet.tileGroups.first { $0.name == "Sand"}
        //        let tundraTiles = tileSet.tileGroups.first { $0.name == "Tundra"}
        //        let waterTiles = tileSet.tileGroups.first { $0.name == "Water"}
        //        let townTiles = tileSet.tileGroups.first { $0.name == "Town"}
        //        let planeTiles = tileSet.tileGroups.first { $0.name == "Plane"}
        //        let tankTiles = tileSet.tileGroups.first { $0.name == "Tank"}
        //        let fogTiles = tileSet.tileGroups.first { $0.name == "Fog"}
        //        let jungleTiles = tileSet.tileGroups.first { $0.name == "Jungle"}
        //        let swampTiles = tileSet.tileGroups.first { $0.name == "Swamp"}
        //        let snowTiles = tileSet.tileGroups.first { $0.name == "Snow"}
        //        let plainsTiles = tileSet.tileGroups.first { $0.name == "Plains"}
        //
        //        map.fill(with: grassTiles)
        
        var numTiles: CGSize = CGSize(width: 0.0, height: 0.0)
        
        for (rowIndex, row) in map.tiles.enumerated() {
            numTiles.width = CGFloat(rowIndex)
            
            for (colIndex, tile) in row.enumerated() {
                
                if let tileType = gameTiles[tile.id] {
                    if tileType == "Tank" || tileType == "Plane" || tileType == "Town" {
                        if let tileGroup = tileSet.tileGroups.first(where: { $0.name == tileType}) {
                            unitsMap.setTileGroup(tileGroup, forColumn: colIndex, row: rowIndex)
                            terrainMap.setTileGroup(grassTiles, forColumn: colIndex, row: rowIndex)
                        }
                    }
                    else {
                        if let tileGroup = tileSet.tileGroups.first(where: { $0.name == tileType}) {
                            terrainMap.setTileGroup(tileGroup, forColumn: colIndex, row: rowIndex)
                            
                        }
                    }
                }
            }
        }
        
        //        for row in 0..<rows {
        //            for col in 0..<cols {
        //                let randomInt = Int.random(in: 0..<100)
        //                if randomInt >= 0 && randomInt < 20 {
        //                    terrainMap.setTileGroup(grassTiles, forColumn: col, row: row)
        //                }
        //                else if randomInt >= 20 && randomInt < 40 {
        //                    terrainMap.setTileGroup(plainsTiles, forColumn: col, row: row)
        //                }
        //                else if randomInt >= 40 && randomInt < 50 {
        //                    terrainMap.setTileGroup(sandTiles, forColumn: col, row: row)
        //                }
        //                else if randomInt >= 50 && randomInt < 60 {
        //                    terrainMap.setTileGroup(swampTiles, forColumn: col, row: row)
        //                }
        //                else if randomInt >= 60 && randomInt < 70 {
        //                    terrainMap.setTileGroup(waterTiles, forColumn: col, row: row)
        //                }
        //                else if randomInt >= 70 && randomInt < 90 {
        //                    terrainMap.setTileGroup(jungleTiles, forColumn: col, row: row)
        //                }
        //                else if randomInt >= 90 && randomInt < 100 {
        //                    terrainMap.setTileGroup(snowTiles, forColumn: col, row: row)
        //                }
        //                else if randomInt >= 101 && randomInt < 100 {
        //                    terrainMap.setTileGroup(fogTiles, forColumn: col, row: row)
        //                }
        //            }
        //        }
        //
        //        for row in 0..<rows {
        //            for col in 0..<cols {
        //                let randomInt = Int.random(in: 0..<100)
        //                if randomInt >= 0 && randomInt < 10 {
        //                    unitsMap.setTileGroup(tankTiles, forColumn: col, row: row)
        //                }
        //                else if randomInt >= 20 && randomInt < 30 {
        //                    unitsMap.setTileGroup(planeTiles, forColumn: col, row: row)
        //                }
        //                else if randomInt >= 30 && randomInt < 40 {
        //                    unitsMap.setTileGroup(townTiles, forColumn: col, row: row)
        //                }
        //            }
        //        }
        
        addChild(terrainMap)
        addChild(unitsMap)
    }
    
//    func toggleTexture() {
//        if (mapName == "zero") {
//            mapName = "one"
//        }
//        else if (mapName == "one") {
//            mapName = "two"
//        }
//        else if (mapName == "two") {
//            mapName = "three"
//        }
//        else {
//            mapName = "zero"
//        }
//
//        if mapName == "zero" {
//            let action = SKAction.setTexture(mapViewModel.texture0, resize: false)
//            background.run(action)
//        }
//        if mapName == "one" {
//            let action = SKAction.setTexture(mapViewModel.texture1, resize: false)
//            background.run(action)
//        }
//        else if mapName == "two" {
//            let action = SKAction.setTexture(mapViewModel.texture2, resize: false)
//            background.run(action)
//        }
//        else if mapName == "three" {
//            let action = SKAction.setTexture(mapViewModel.texture3, resize: false)
//            background.run(action)
//        }
//
//        mapViewModel.changeMap(mapName: mapName)
//        gameCamera.position = mapViewModel.cameraPosition
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        var location: CGPoint!
//
//        for touch in touches {
//            location = touch.location(in: self)
//            let touchedNode = self.nodes(at: location)
//
//
//        }
    }
    
    func showAiPath() {
        
    }
}
