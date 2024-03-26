//
//  SettingsViewControllerProtocol.swift
//  Pandemic
//
//  Created by kalmahik on 27.03.2024.
//

import Foundation

protocol SettingsViewControllable: AnyObject {
    var configHelper: ConfigHelping { get set }
    
    func addSubViews()
    func applyConstraints()
    func didTapRunButton()
}
