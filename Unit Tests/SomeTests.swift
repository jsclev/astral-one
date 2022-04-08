//
//  SomeTests.swift
//  Unit Tests
//
//  Created by John Cleveland on 4/8/22.
//  Copyright © 2022 ZippyZen, LLC. All rights reserved.
//

import XCTest
import Astral_One_Engine

class SomeTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        //      var gridGraph = GameGridGraphNode(row: 0, col: 0)
        //      var turn = Turn(id: 0, year: 0, ordinal: 0, displayText: "")
        //      var someClass = SomeClass2()
        var gridGraph = GameGridGraph()
        var node = GameGridGraphNode(row: 0, col: 0)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        var gridGraph = GameGridGraph()
        var nodes: [GameGridGraphNode] = []
        
        for row in 0..<50 {
            for col in 0..<50 {
                nodes.append(GameGridGraphNode(row: row, col: col))
            }
        }

        self.measure {
            for node in nodes {
                gridGraph.addNode(nodeToAdd: node)
            }
            
            for node in nodes {
                gridGraph.removeNode(nodeToDelete: node)
            }
        }
    }
    
}
