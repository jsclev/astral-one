//
//  TechTree.swift
//  Engine
//
//  Created by John Cleveland on 5/20/22.
//

import Foundation

public class TechTree {
    public let advances: [AdvanceType: Advance]
    
    public init() {
        let pottery = Advance(type: AdvanceType.Pottery, parents: [])
        let alphabet = Advance(type: AdvanceType.Alphabet, parents: [])
        let warriorCode = Advance(type: AdvanceType.Alphabet, parents: [])
        let horsebackRiding = Advance(type: AdvanceType.Alphabet, parents: [])
        let bronzeWorking = Advance(type: AdvanceType.Alphabet, parents: [])
        let masonry = Advance(type: AdvanceType.Alphabet, parents: [])
        let ceremonialBurial = Advance(type: AdvanceType.Alphabet, parents: [])
        let mapMaking = Advance(type: AdvanceType.Alphabet, parents: [alphabet])
        let writing = Advance(type: AdvanceType.Alphabet, parents: [alphabet])
        let codeOfLaws = Advance(type: AdvanceType.Alphabet, parents: [alphabet])
        let mathematics = Advance(type: AdvanceType.Alphabet, parents: [alphabet])
        let feudalism = Advance(type: AdvanceType.Alphabet, parents: [warriorCode])
        let theWheel = Advance(type: AdvanceType.Alphabet, parents: [horsebackRiding])
        let ironWorking = Advance(type: AdvanceType.Alphabet, parents: [])
        let currency = Advance(type: AdvanceType.Alphabet, parents: [])

        
        advances = [
            AdvanceType.Pottery: pottery,
            AdvanceType.Alphabet: alphabet
        ]
    }
    
    public func startResearching(advanceType: AdvanceType) {
        if let advance = advances[advanceType] {
            advance.isResearching = true
        }
    }
    
    public func completeResearch(advanceType: AdvanceType) {
        if let advance = advances[advanceType] {
            advance.isResearching = false
            advance.completed = true
        }
    }
    
    
}
