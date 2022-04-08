import Foundation
import GameplayKit

public class Map {
    private let graph = GameGridGraph()
    private var unitType: UnitType = UnitType.Explorer
    
    public var width: Int {
        graph.gridWidth
    }
    
    public var height: Int {
        graph.gridHeight
    }
    
    public func setUnitType(unitType: UnitType) {
        self.unitType = unitType
    }
    
    public init(width: Int32, height: Int32) {
//        graph = GKGridGraph<GameNode>(fromGridStartingAt: SIMD2<Int32>(0, 0),
//                                      width: width,
//                                      height: height,
//                                      diagonalsAllowed: true,
//                                      nodeClass: GameNode.self)
    }
    
    public func prune() {
        var nodesToRemove: [GameNode] = []
        for row in 0..<graph.gridHeight {
            for col in 0..<graph.gridWidth {
                if let node = getNode(row: row, col: col) {
                    let tiles = node.getTiles()
                    
                    if tiles.count > 0 &&
                        (tiles[0].spec.terrainType == TerrainType.Water ||
                         tiles[0].spec.terrainType == TerrainType.Glacier) {
//                        nodesToRemove.append(node)
                        //                        graph.remove([localNode])
                    }
                }
            }
        }
        
//        graph.remove(nodesToRemove)
    }
    
    public func getNode(row: Int, col: Int) -> GameGridGraphNode? {
        return graph.node(row: row, col: col)
    }
    
    public func getTiles(row: Int, col: Int) -> [Tile] {
        if let node = getNode(row: row, col: col) {
            return node.getTiles()
        }
        
        return []
    }
    
    public func addTile(row: Int, col: Int, tile: Tile) {
        if let node = graph.node(row: row, col: col) {
            node.addTile(tile: Tile(id: tile.id,
                                    spec: tile.spec,
                                    ordinal: node.getTiles().count))
        }
        else {
            let node = GameGridGraphNode(row: row, col: col)
            node.addTile(tile: Tile(id: tile.id,
                                    spec: tile.spec,
                                    ordinal: node.getTiles().count))
            graph.addNode(nodeToAdd: node)
        }
    }
    
    public func getNumLayers() -> Int {
        var numLayers: Int = 0
        for row in 0..<width {
            for col in 0..<height {
                if let node = graph.node(row: row, col: col) {
                    let myLayerCount = node.getTiles().count
                    if myLayerCount > numLayers {
                        numLayers = myLayerCount
                    }
                }
            }
        }

        return numLayers
    }
    
    public func findPath(from: SIMD2<Int32>, to: SIMD2<Int32>) -> [GKGraphNode] {
        let startNode = graph.node(row: Int(from.y), col: Int(from.x))
        let endNode = graph.node(row: Int(to.y), col: Int(to.x))
        if let startNode = startNode, let endNode = endNode {
//            return graph.findPath(from: startNode, to: endNode)
        }
        
        return []
    }
    
    public func log() {
        print("****************************************************************")
        print("Map dimensions: [\(graph.gridWidth), \(graph.gridHeight)]")
        
        for row in 0..<width {
            for col in 0..<height {
                if let node = graph.node(row: row, col: col) {
                    print("Node [\(row),\(col)]: \(node.getTiles().count) tiles.")
//                    for tile in node.getTiles() {
//                        if let tileType = Constants.tiles[tile.id] {
//                            if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileType }) {
//                                unitsMap.setTileGroup(tileGroup, forColumn: col, row: row)
//                            }
//                        }
//                    }
                }
            }
        }
        
        print("****************************************************************")
    }
    
    public func getUnit() -> Unit? {
        for row in 0..<width {
            for col in 0..<height {
                if let node = graph.node(row: row, col: col) {
                    let tiles = node.getTiles()
                    
                    for tile in tiles {
                        if tile.spec.tileType == TileType.Unit {
                            return Unit(name: "Settler", maxHP: 10)
                        }
                    }
                }
            }
        }
        
        return nil
    }
}
