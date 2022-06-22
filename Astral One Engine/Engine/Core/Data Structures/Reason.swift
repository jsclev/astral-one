//
//  Reason.swift
//  Engine
//
//  Created by John Cleveland on 6/21/22.
//

import Foundation

public class Reason {
    public let value: Bool
    public let message: String
    
    public init(value: Bool, message: String) {
        self.value = value
        self.message = message
    }
}
