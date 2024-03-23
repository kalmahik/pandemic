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
    
    static let defaultConfig = Config(groupSize: 100, infectionFactor: 3, refrashRate: 1)
}
