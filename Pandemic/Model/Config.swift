//
//  Config.swift
//  Pandemic
//
//  Created by kalmahik on 23.03.2024.
//

import Foundation

struct Config {
    let groupSize: Int
    let infectionFactor: Int
    let refrashRate: Int
    
    init(groupSize: Int, infectionFactor: Int, refrashRate: Int) {
        self.groupSize = groupSize
        self.infectionFactor = infectionFactor
        self.refrashRate = refrashRate
    }
}
