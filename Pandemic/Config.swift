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
    
    static let defaultConfig = Config(
        groupSize: 100,
        infectionFactor: 3,
        refrashRate: 1
    )
    
    init(groupSize: Int, infectionFactor: Int, refrashRate: Int) {
        self.groupSize = groupSize
        self.infectionFactor = infectionFactor
        self.refrashRate = refrashRate
    }
    
    init(groupSize: String?, infectionFactor: String?, refrashRate: String?) {
        let groupSizeInt = Int(groupSize ?? "0") ?? 0
        var infectionFactorInt = Int(infectionFactor ?? "0") ?? 0
        if infectionFactorInt >= 8 {
            infectionFactorInt = 8
        }
        let refrashRateInt = Int(refrashRate ?? "0") ?? 0
        self.groupSize = groupSizeInt == 0 ? Config.defaultConfig.groupSize : groupSizeInt
        self.infectionFactor = infectionFactorInt == 0 ? Config.defaultConfig.infectionFactor : infectionFactorInt
        self.refrashRate = refrashRateInt == 0 ? Config.defaultConfig.refrashRate : refrashRateInt
    }
}
