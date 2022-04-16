import Foundation

public class GridGraph {
    var nodes: Dictionary<ValueNode, Set<ValueNode>> = [:]
    public let width: Int
    public let height: Int
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    @discardableResult
    public func add(node: ValueNode) -> Dictionary<ValueNode, Set<ValueNode>> {
        if nodes[node] == nil {
            nodes[node] = Set<ValueNode>()
            
            attachConnections(node: node)
        }
        
        return nodes
    }
    
    private func attachConnections(node: ValueNode) {
        if let northwest = self.node(row: node.row - 1, col: node.col - 1) {
            addConnection(from: node, to: northwest)
            addConnection(from: northwest, to: node)
        }
        
        if let north = self.node(row: node.row - 1, col: node.col) {
            addConnection(from: node, to: north)
            addConnection(from: north, to: node)
        }
        
        if let northeast = self.node(row: node.row - 1, col: node.col + 1) {
            addConnection(from: node, to: northeast)
            addConnection(from: northeast, to: node)
        }
        
        if let east = self.node(row: node.row, col: node.col + 1) {
            addConnection(from: node, to: east)
            addConnection(from: east, to: node)
        }
        
        if let southeast = self.node(row: node.row + 1, col: node.col + 1) {
            addConnection(from: node, to: southeast)
            addConnection(from: southeast, to: node)
        }
        
        if let south = self.node(row: node.row + 1, col: node.col) {
            addConnection(from: node, to: south)
            addConnection(from: south, to: node)
        }
        
        if let southwest = self.node(row: node.row + 1, col: node.col - 1) {
            addConnection(from: node, to: southwest)
            addConnection(from: southwest, to: node)
        }
        
        if let west = self.node(row: node.row, col: node.col - 1) {
            addConnection(from: node, to: west)
            addConnection(from: west, to: node)
        }
    }
    
    @discardableResult
    public func addConnection(from: ValueNode, to: ValueNode) -> Dictionary<ValueNode, Set<ValueNode>> {
//        add(node: from)
//        add(node: to)
        
        // FIXME Need to rewrite the implementation below in a more robust way
        nodes[from]?.insert(to)
        
        return nodes
    }
    
    @discardableResult
    public func removeConnection(origin: ValueNode, destination: ValueNode) -> Dictionary<ValueNode, Set<ValueNode>>{
        nodes[origin]?.remove(destination)
        
        return nodes
    }
    
    @discardableResult
    public func removeNode(nodeToDelete: ValueNode) -> Dictionary<ValueNode, Set<ValueNode>> {
        nodes[nodeToDelete] = nil
        
        for node in nodes.keys {
            removeConnection(origin: node, destination: nodeToDelete)
        }
        
        return nodes
    }
    
    public func node(row: Int, col: Int) -> ValueNode? {
        for node in nodes.keys {
            if node.row == row && node.col == col {
                return node
            }
        }
        
        return nil
    }
    
    public func neighbors(of: ValueNode) -> Set<ValueNode> {
        if let neighbors = nodes[of] {
            return neighbors
        }
        
        return Set<ValueNode>()
    }
    
    public func getChebyshevDistance(from: ValueNode, to: ValueNode) -> Int {
        // This is also known as the "Chessboard distance"
        // See https://towardsdatascience.com/3-distances-that-every-data-scientist-should-know-59d864e5030a
        let xDistance = abs(to.col - from.col)
        let yDistance = abs(to.row - from.row)
        
        return max(xDistance, yDistance)
    }
    
    public func findPath(start: ValueNode, end: ValueNode) -> [ValueNode] {
        var frontier = QueueArray<ValueNode>()
        frontier.enqueue(start)

        var utilityToNode = Dictionary<ValueNode, Double>()
        utilityToNode[start] = start.getValue()
        
        var visitedNodes = Set<ValueNode>()
        visitedNodes.insert(start)
        
        while !frontier.isEmpty {
            print("There are \(frontier.count) nodes in the frontier.")
            
            if let current = frontier.dequeue() {
                if current == end {
                    break
                }
                
                let neighbors2 = self.neighbors(of: current)
                print("Current node is \(current.description), neighbor count: \(neighbors2.count)")
                
                var maxValue = 0.0
                for neighbor in neighbors(of: current) {
                    if !visitedNodes.contains(neighbor) {
                        if neighbor.getValue() >= maxValue {
                            maxValue = neighbor.getValue()
                        }
                    }
                }
                
                for neighbor in neighbors(of: current) {
                    if neighbor.getValue() == maxValue && !visitedNodes.contains(neighbor) {
                        print("Inspecting utility of neighbor \(neighbor.description) of \(current.description)")

                        // Calculate the new utility of this neighbor
                        var newUtility = utilityToNode[current]! + neighbor.getValue()
                        newUtility -= 0.5 // Movement cost
                            
                        // We want to add this neighbor to the frontier in two circumstances:
                        // 1) If we have not yet explored this node, or
                        // 2) If the utility of this neighbor increases the path's utility
                        utilityToNode[neighbor] = newUtility
                        frontier.enqueue(neighbor)
                        visitedNodes.insert(neighbor)
                        neighbor.parent = current
                    }
                }
            }
        }
        
        var path: [ValueNode] = []
        var current = end
        path.append(current)

        while current.parent != nil {
            if let parent = current.parent {
                current = parent
                path.append(current)
            }
        }
        
        return path.reversed()
    }
    
    public func log() {
        print("****************************************************************")
        print("Map dimensions: [\(width), \(height)]")
        
//        for row in 0..<width {
//            for col in 0..<height {
//                if let node = node(row: row, col: col) {
//                    print("Node [\(row),\(col)]: \(node.getUnits().count) units.")
                    //                    for tile in node.getTiles() {
                    //                        if let tileType = Constants.tiles[tile.id] {
                    //                            if let tileGroup = tileset.tileGroups.first(where: { $0.name == tileType }) {
                    //                                unitsMap.setTileGroup(tileGroup, forColumn: col, row: row)
                    //                            }
                    //                        }
                    //                    }
//                }
//            }
//        }
        
        print("****************************************************************")
    }
    
    
}
