import Foundation

public class GridGraph {
    var nodes: Dictionary<Node, Set<Node>> = [:]
    public let width: Int
    public let height: Int
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    @discardableResult
    public func add(node: Node) -> Dictionary<Node, Set<Node>> {
        if nodes[node] == nil {
            nodes[node] = Set<Node>()
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
}
