import Foundation
import GameplayKit

public struct Map {
    public var tiles: [[Tile]] = [[]]
    public var width: Int32 = 0
    public var height: Int32 = 0
    private var graph: GKGridGraph<GameNode>
    
    public init(width: Int32, height: Int32) {
        self.width = width
        self.height = height
        
        tiles = Array(repeating: Array(repeating: Tile(), count: Int(self.width)), count: Int(self.height))
        graph = GKGridGraph<GameNode>()
    }
    
    mutating public func bake() {
        graph = GKGridGraph<GameNode>(fromGridStartingAt: SIMD2<Int32>(0, 0),
                                      width: 80,
                                      height: 80,
                                      diagonalsAllowed: true,
                                      nodeClass: GameNode.self)
        
        for (rowIndex, row) in tiles.enumerated() {
            for (colIndex, tile) in row.enumerated() {
                let position = SIMD2<Int32>(Int32(rowIndex), Int32(colIndex))
                if let currentNode = graph.node(atGridPosition: position) {
                    currentNode.tile = tile
                }
            }
        }
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
        print("Graph grid dimensions: [\(graph.gridWidth), \(graph.gridHeight)]")
        
        // Draw top border
        var verticalBorder: String = ""
        for _ in 0..<graph.gridWidth {
            verticalBorder += " -"
        }
        print(verticalBorder)
        
        for row in 0..<graph.gridHeight {
            var rowString: String = "|"
            for col in 0..<graph.gridWidth {
                rowString += " |"
                if let node = graph.node(atGridPosition: SIMD2<Int32>(Int32(row), Int32(col))) {
                    print("\(node.connectedNodes.count)")
                }
            }
            print(rowString)
            print(verticalBorder)
        }
    }
}
