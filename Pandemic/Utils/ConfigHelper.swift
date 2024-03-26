//
//  ConfigHelper.swift
//  Pandemic
//
//  Created by kalmahik on 23.03.2024.
//

import Foundation

final class ConfigHelper {
    static let shared = ConfigHelper()

    private(set) var config: Config = .defaultConfig
    
    private init() {}
    
    func updateConfig(config: Config) {
        self.config = config
    }
}
