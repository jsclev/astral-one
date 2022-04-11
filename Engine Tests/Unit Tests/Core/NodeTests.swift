import XCTest
import Engine


class NodeTests: XCTestCase {
    func testPerformanceExample() throws {
        var gridGraph = GridGraph(size: 5)
        var nodes: [Node] = []
        
        for row in 0..<50 {
            for col in 0..<50 {
                nodes.append(Node(row: row, col: col))
            }
        }
        
        self.measure {
            for node in nodes {
                gridGraph.add(node: node)
            }
            
            for node in nodes {
                gridGraph.removeNode(nodeToDelete: node)
            }
        }
    }

}
