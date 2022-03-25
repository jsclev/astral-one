import Foundation
import GameplayKit

public struct Map {
//    private var tiles: [[[Tile]]] = [[[]]]
//    private var width: Int32 = 0
//    private var height: Int32 = 0
    private let graph: GKGridGraph<GameNode>
    
    public var width: Int {
        graph.gridWidth
    }
    
    public var height: Int {
        graph.gridHeight
    }
    
    public init(width: Int32, height: Int32) {
//        self.width = width
//        self.height = height
        
//        let layerArray: [Tile] = []
//        let rowArray = Array(repeating: layerArray, count: Int(self.width))
        
//        tiles = Array(repeating: rowArray, count: Int(self.height))
        
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
    
//    public func getTiles() -> [[[Tile]]] {
//        return tiles
//    }
    
    public func getNode(row: Int, col: Int) -> GameNode? {
        return graph.node(atGridPosition: SIMD2<Int32>(Int32(row), Int32(col)))
    }
    
    public func getTiles(row: Int, col: Int) -> [Tile] {
        if let node = getNode(row: row, col: col) {
            return node.getTiles()
        }
        
        return []
    }
    
    mutating public func setTile(row: Int, col: Int, layer: Int, tile: Tile) {
        if let node = graph.node(atGridPosition: SIMD2<Int32>(Int32(row), Int32(col))) {
            node.setTile(tile: Tile(id: tile.id,
                                    terrainType: tile.terrainType,
                                    layerIndex: layer))
        }
    }
    
    public func getMaxNumLayers() -> Int {
        return 2
//        var maxNumLayers: Int = 0
//        for row in tiles {
//            for col in row {
//                if col.count > maxNumLayers {
//                    maxNumLayers = col.count
//                }
//            }
//        }
//
//        return maxNumLayers
    }
    
    private func getSurroundingPositions(position: SIMD2<Int32>) -> [SIMD2<Int32>] {
        return []
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
        
        // Draw top border
//        var verticalBorder: String = ""
//        for _ in 0..<graph.gridWidth {
//            verticalBorder += " -"
//        }
//        print(verticalBorder)
//
//        for row in 0..<graph.gridHeight {
//            var rowString: String = "|"
//            for col in 0..<graph.gridWidth {
//                rowString += " |"
//                if let node = graph.node(atGridPosition: SIMD2<Int32>(Int32(row), Int32(col))) {
//                    print("\(node.connectedNodes.count)")
//                }
//            }
//            print(rowString)
//            print(verticalBorder)
//        }
    }
}
