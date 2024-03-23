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
    let humanSize: Int
    
    static let defaultConfig = Config(
        groupSize: 100,
        infectionFactor: 3,
        refrashRate: 1,
        humanSize: 48
    )
    
    init(groupSize: Int, infectionFactor: Int, refrashRate: Int, humanSize: Int) {
        self.groupSize = groupSize
        self.infectionFactor = infectionFactor
        self.refrashRate = refrashRate
        self.humanSize = humanSize
    }
    
    init(groupSize: String?, infectionFactor: String?, refrashRate: String?, humanSize: String?) {
        let groupSizeInt = Int(groupSize ?? "0") ?? 0
        var infectionFactorInt = Int(infectionFactor ?? "0") ?? 0
        if infectionFactorInt >= 8 {
            infectionFactorInt = 8
        }
        let refrashRateInt = Int(refrashRate ?? "0") ?? 0
        var humanSizeInt = Int(humanSize ?? "0") ?? 0
        if humanSizeInt >= 96 {
            humanSizeInt = 96
        }
        if humanSizeInt < 24 {
            humanSizeInt = Config.defaultConfig.humanSize
        }
        self.groupSize = groupSizeInt == 0 ? Config.defaultConfig.groupSize : groupSizeInt
        self.infectionFactor = infectionFactorInt == 0 ? Config.defaultConfig.infectionFactor : infectionFactorInt
        self.refrashRate = refrashRateInt == 0 ? Config.defaultConfig.refrashRate : refrashRateInt
        self.humanSize = humanSizeInt
    }
}
