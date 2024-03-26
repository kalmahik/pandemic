//
//  SettingsViewController.swift
//  Pandemic
//
//  Created by kalmahik on 22.03.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
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
        label.text = TextConstants.groupSizeTitle
        return label
    }()
    
    private lazy var groupSizeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = TextConstants.groupSizeMessage
        textField.text = "\(configHelper.config.groupSize)"
        return textField
    }()
    
    private let infectionFactorLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.infectionFactorTitle
        return label
    }()
    
    private lazy var infectionFactorTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = TextConstants.infectionFactorMessage
        textField.text = "\(configHelper.config.infectionFactor)"
        return textField
    }()
    
    private let refreshRateLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.refrashRateTitle
        return label
    }()
    
    private lazy var refreshRateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = TextConstants.refrashRateMessage
        textField.text = "\(configHelper.config.refrashRate)"
        return textField
    }()
    
    private lazy var runButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle(TextConstants.runModulationButton, for: .normal)
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
            refrashRate: refreshRateTextField.text
        )
    }
}

extension SettingsViewController {
    private func addSubViews() {
        [
            groupSizeLabel,
            groupSizeTextField,
            infectionFactorLabel,
            infectionFactorTextField,
            refreshRateLabel,
            refreshRateTextField,
            runButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            rootStack.addArrangedSubview($0)
        }
        rootStack.translatesAutoresizingMaskIntoConstraints = false
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
            
            runButton.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            runButton.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),
            runButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

