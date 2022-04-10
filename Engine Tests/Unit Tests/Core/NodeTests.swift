import XCTest
import Astral_One_Engine


class NodeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

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