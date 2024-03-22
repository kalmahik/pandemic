//
//  ViewController.swift
//  Pandemic
//
//  Created by kalmahik on 22.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
    }
    
    private let rootStack: UIStackView =  {
        let rootStack: UIStackView = UIStackView()
        rootStack.translatesAutoresizingMaskIntoConstraints = false
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
        textField.text = "100"
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
        textField.text = "4"
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
        textField.text = "1"
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Запустить моделирование", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapRunButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapRunButton() {
        let modulationViewController = ModulationViewController()
        navigationController?.pushViewController(modulationViewController, animated: true)
    }
}

extension ViewController {
    private func addSubViews() {
        [groupSizeLabel,
         groupSizeTextField,
         infectionFactorLabel,
         infectionFactorTextField,
         refreshRateLabel,
         refreshRateTextField,
         loginButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
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
            
            loginButton.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor)
        ])
    }
}

