//
//  Plan.swift
//  Engine
//
//  Created by John Cleveland on 5/18/22.
//

import Foundation

public class Plan {
    public var research: [Action] = []
    public var cityLanes: [[Action]] = [[]]
    
    public init(cities: [City]) {
        for _ in cities {
            cityLanes.append([])
        }
    }
}
