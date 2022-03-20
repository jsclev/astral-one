import Foundation
import GameplayKit

public struct Map {
    public var tiles: [[Tile]] = [[]]
    var width: Int32 = 0
    var height: Int32 = 0
    var graph: GKGridGraph<GKGridGraphNode>
    
    init(width: Int32, height: Int32) {
        self.width = width
        self.height = height
        
        tiles = Array(repeating: Array(repeating: Tile(), count: Int(self.width)), count: Int(self.height))
        
        graph = GKGridGraph<GKGridGraphNode>(fromGridStartingAt: SIMD2<Int32>(0, 0),
                                             width: width,
                                             height: height,
                                             diagonalsAllowed: true)
    }
    
    public func bake() {
        var nodesToRemove: [GKGridGraphNode] = []
        
        for (rowIndex, row) in tiles.enumerated() {
            for (colIndex, tile) in row.enumerated() {
                if !tile.walkable {
                    let position = SIMD2<Int32>(Int32(rowIndex), Int32(colIndex))
                    
                    if let nodeToRemove = graph.node(atGridPosition: position) {
                        nodesToRemove.append(nodeToRemove)
                    }
                }
                //                if tile.id != "0" && !tile.walkable {
                //                    print("Tile [\(rowIndex), \(colIndex)]: \(tile.id), walkable: \(tile.walkable)")
                //                }
            }
        }
        
        graph.remove(nodesToRemove)

    }
}
