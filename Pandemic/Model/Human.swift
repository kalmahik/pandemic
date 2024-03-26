//
//  Human.swift
//  Pandemic
//
//  Created by kalmahik on 22.03.2024.
//

import Foundation

struct Human {
    private(set) var isSick: Bool
    private(set) var index: Int
    
    mutating func infect() {
        isSick = true
    }
}
