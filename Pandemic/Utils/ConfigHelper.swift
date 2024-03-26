//
//  ConfigHelper.swift
//  Pandemic
//
//  Created by kalmahik on 23.03.2024.
//

import Foundation

final class ConfigHelper {
    static let shared = ConfigHelper()
    
    static let defaultConfig = Config(groupSize: 100, infectionFactor: 3, refrashRate: 1)
    
    private(set) var config: Config = ConfigHelper.defaultConfig
    
    private init() {}
    
    func makeConfig(groupSize: String?, infectionFactor: String?, refrashRate: String?) {
        let groupSizeInt = Int(groupSize ?? "0") ?? 0
        var infectionFactorInt = Int(infectionFactor ?? "0") ?? 0
        if infectionFactorInt >= 8 {
            infectionFactorInt = 8
        }
        let refrashRateInt = Int(refrashRate ?? "0") ?? 0
        let groupSize = groupSizeInt == 0 ? ConfigHelper.defaultConfig.groupSize : groupSizeInt
        let infectionFactor = infectionFactorInt == 0 ? ConfigHelper.defaultConfig.infectionFactor : infectionFactorInt
        let refrashRate = refrashRateInt == 0 ? ConfigHelper.defaultConfig.refrashRate : refrashRateInt
        config = Config(groupSize: groupSize, infectionFactor: infectionFactor, refrashRate: refrashRate)
    }

}
