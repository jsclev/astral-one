import Foundation
import GameplayKit

public class Map {
    var nodes: Dictionary<Node, Set<Node>> = [:]
    public let width: Int
    public let height: Int
    private let minMovementCost: Float = 0.000001
    private var movementCosts: [[Float]] = [[]]
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.movementCosts = Array(repeating: Array(repeating: minMovementCost, count: width), count: height)
    }
    
    @discardableResult
    public func add(node: Node) -> Dictionary<Node, Set<Node>> {
        if nodes[node] == nil {
            nodes[node] = Set<Node>()
            
            movementCosts[node.row][node.col] = node.getMovementCost()
        }
        
        return nodes
    }
    
    @discardableResult
    public func addConnection(from: Node, to: Node) -> Dictionary<Node, Set<Node>> {
        add(node: from)
        add(node: to)
        
        // FIXME Need to rewrite the implementation below in a more robust way
        nodes[from]?.insert(to)
        
        return nodes
    }
    
    @discardableResult
    public func removeConnection(origin: Node, destination: Node) -> Dictionary<Node, Set<Node>>{
        nodes[origin]?.remove(destination)
        
        return nodes
    }
    
    @discardableResult
    public func removeNode(nodeToDelete: Node) -> Dictionary<Node, Set<Node>> {
        nodes[nodeToDelete] = nil
        
        for node in nodes.keys {
            removeConnection(origin: node, destination: nodeToDelete)
        }
        
        return nodes
    }
    
    public func node(row: Int, col: Int) -> Node? {
        for node in nodes.keys {
            if node.row == row && node.col == col {
                return node
            }
        }
        
        return nil
    }
    
    public func getUnits(row: Int, col: Int) -> [Unit] {
        if let node = node(row: row, col: col) {
            return node.getUnits()
        }
        
        return []
    }
    
    public func getMovementCosts() -> [[Float]] {
        return movementCosts
    }
    
    public func getMovementCost(fromRow: Int, fromCol: Int, toRow: Int, toCol: Int) -> Float {
        var movementCost: Float = 0.0
        
        if let node = node(row: toRow, col: toCol) {
            movementCost += node.getMovementCost()
        }
        
        return movementCost == 0.0 ? minMovementCost : movementCost
    }
    
    public func getNumLayers() -> Int {
        var numLayers: Int = 1
        for row in 0..<width {
            for col in 0..<height {
                if let node = node(row: row, col: col) {
                    let myLayerCount = node.getUnits().count
                    if myLayerCount > numLayers {
                        numLayers = myLayerCount
                    }
                }
            }
        }

        return numLayers
    }
    
    public func findPath(from: SIMD2<Int32>, to: SIMD2<Int32>) -> [GKGraphNode] {
//        let startNode = graph.node(row: Int(from.y), col: Int(from.x))
//        let endNode = graph.node(row: Int(to.y), col: Int(to.x))
//        if let startNode = startNode, let endNode = endNode {
//            return graph.findPath(from: startNode, to: endNode)
//        }
        
        return []
    }
    
    public func log() {
        print("****************************************************************")
        print("Map dimensions: [\(width), \(height)]")
        
        for row in 0..<width {
            for col in 0..<height {
                if let node = node(row: row, col: col) {
                    print("Node [\(row),\(col)]: \(node.getUnits().count) units.")
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
    
    public func getDistance(fromRow: Int, fromCol: Int, toRow: Int, toCol: Int) -> Int {
        return abs(toRow - fromRow) + abs(toCol - fromCol) + 1
    }
    
    
}
