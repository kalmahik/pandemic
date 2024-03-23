//
//  SettingsViewController.swift
//  Pandemic
//
//  Created by kalmahik on 22.03.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var configHelper = ConfigHelper.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
    }
    
    private let rootStack: UIStackView =  {
        let rootStack: UIStackView = UIStackView()
        rootStack.axis = NSLayoutConstraint.Axis.vertical
        rootStack.distribution = UIStackView.Distribution.fill
        rootStack.alignment = UIStackView.Alignment.leading
        rootStack.spacing = 8
        return rootStack
    }()
    
    private let groupSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Group Size"
        return label
    }()
    
    private let groupSizeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = "Amount of population, more than 1"
        textField.text = "\(Config.defaultConfig.groupSize)"
        return textField
    }()
    
    private let infectionFactorLabel: UILabel = {
        let label = UILabel()
        label.text = "Infection Factor"
        return label
    }()
    
    private let infectionFactorTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = "From 1 to 8"
        textField.text = "\(Config.defaultConfig.infectionFactor)"
        return textField
    }()
    
    private let refreshRateLabel: UILabel = {
        let label = UILabel()
        label.text = "Refresh Rate"
        return label
    }()
    
    private let refreshRateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = "In seconds, more than 1"
        textField.text = "\(Config.defaultConfig.refrashRate)"
        return textField
    }()
    
    private let humanSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Human size"
        return label
    }()
    
    private let humanSizeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = "In px, 24-96 for ex"
        textField.text = "\(Config.defaultConfig.humanSize)"
        return textField
    }()
    
    private lazy var runButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Запустить моделирование", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapRunButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapRunButton() {
        configHelper.updateConfig(config: getConfig())
        let modulationViewController = ModulationViewController()
        navigationController?.pushViewController(modulationViewController, animated: true)
    }
    
    private func getConfig() -> Config {
        return Config(
            groupSize: groupSizeTextField.text,
            infectionFactor: infectionFactorTextField.text,
            refrashRate: refreshRateTextField.text,
            humanSize: humanSizeTextField.text
        )
    }
}

extension SettingsViewController {
    private func addSubViews() {[
        groupSizeLabel,
        groupSizeTextField,
        infectionFactorLabel,
        infectionFactorTextField,
        refreshRateLabel,
        refreshRateTextField,
        humanSizeLabel,
        humanSizeTextField,
        runButton,
    ].forEach {
        $0.translatesAutoresizingMaskIntoConstraints = false
        rootStack.translatesAutoresizingMaskIntoConstraints = false
        rootStack.addArrangedSubview($0)
    }
        view.addSubview(rootStack)
        view.backgroundColor = .white
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            rootStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            rootStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            rootStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            groupSizeTextField.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            groupSizeTextField.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),
            
            infectionFactorTextField.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            infectionFactorTextField.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),
            
            refreshRateTextField.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            refreshRateTextField.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),   
            
            humanSizeLabel.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            humanSizeTextField.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),
            
            runButton.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            runButton.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor)
        ])
    }
}

