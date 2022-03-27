import Foundation
import GameplayKit

public struct Map {
    private let graph: GKGridGraph<GameNode>
    
    public var width: Int {
        graph.gridWidth
    }
    
    public var height: Int {
        graph.gridHeight
    }
    
    public init(width: Int32, height: Int32) {
        graph = GKGridGraph<GameNode>(fromGridStartingAt: SIMD2<Int32>(0, 0),
                                      width: width,
                                      height: height,
                                      diagonalsAllowed: true,
                                      nodeClass: GameNode.self)
    }
    
    mutating public func bake() {
//        for (rowIndex, row) in tiles.enumerated() {
//            for (colIndex, col) in row.enumerated() {
//                for (layerIndex, tile) in col.enumerated() {
//                    let position = SIMD2<Int32>(Int32(rowIndex), Int32(colIndex))
//                    if let node = graph.node(atGridPosition: position) {
//                        node.addTile(tile: tile)
//                    }
//                }
//            }
//        }
    }
    
    public func getNode(row: Int, col: Int) -> GameNode? {
        return graph.node(atGridPosition: SIMD2<Int32>(Int32(row), Int32(col)))
    }
    
    public func getTiles(row: Int, col: Int) -> [Tile] {
        if let node = getNode(row: row, col: col) {
            return node.getTiles()
        }
        
        return []
    }
    
    mutating public func addTile(row: Int, col: Int, tile: Tile) {
        if let node = graph.node(atGridPosition: SIMD2<Int32>(Int32(row), Int32(col))) {
            node.addTile(tile: Tile(id: tile.id,
                                    spec: tile.spec,
                                    ordinal: node.getTiles().count))
        }
    }
    
    public func getNumLayers() -> Int {
        var numLayers: Int = 0
        for row in 0..<width {
            for col in 0..<height {
                if let node = graph.node(atGridPosition: SIMD2<Int32>(Int32(row), Int32(col))) {
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
        let startNode = graph.node(atGridPosition: from)
        let endNode = graph.node(atGridPosition: to)
        if let startNode = startNode, let endNode = endNode {
            return graph.findPath(from: startNode, to: endNode)
        }
        
        return []
    }
    
    public func log() {
        print("****************************************************************")
        print("Map dimensions: [\(graph.gridWidth), \(graph.gridHeight)]")
        
        for row in 0..<width {
            for col in 0..<height {
                if let node = graph.node(atGridPosition: SIMD2<Int32>(Int32(row), Int32(col))) {
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
}
