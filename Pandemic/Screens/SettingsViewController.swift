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
        registerForKeyboardNotifications()
    }
    
    deinit {
        unregisterForKeyboardNotifications()
    }
    
    private let rootScroll: UIScrollView = {
        let scrollview = UIScrollView()
        return scrollview
    }()
    
    private let rootStack: UIStackView =  {
        let rootStack: UIStackView = UIStackView()
        rootStack.axis = NSLayoutConstraint.Axis.vertical
        rootStack.distribution = UIStackView.Distribution.fill
        rootStack.alignment = UIStackView.Alignment.leading
        rootStack.spacing = 8
        return rootStack
    }()
    
    private let iconLabel: UILabel = {
        let label = UILabel()
        label.text = "😷"
        label.font = UIFont.systemFont(ofSize: 180)
        label.textAlignment = .center
        return label
    }()
    
    private let groupSizeLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.groupSizeTitle
        return label
    }()
    
    private lazy var groupSizeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = LocalizedStrings.groupSizeMessage
        textField.text = "\(configHelper.config.groupSize)"
        return textField
    }()
    
    private let infectionFactorLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.infectionFactorTitle
        return label
    }()
    
    private lazy var infectionFactorTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = LocalizedStrings.infectionFactorMessage
        textField.text = "\(configHelper.config.infectionFactor)"
        return textField
    }()
    
    private let refreshRateLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.refrashRateTitle
        return label
    }()
    
    private lazy var refreshRateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = LocalizedStrings.refrashRateMessage
        textField.text = "\(configHelper.config.refrashRate)"
        return textField
    }()
    
    private lazy var runButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle(LocalizedStrings.runModulationButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapRunButton), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
    }()
    
    @objc internal func didTapRunButton() {
        configHelper.makeConfig(
            groupSize: groupSizeTextField.text,
            infectionFactor: infectionFactorTextField.text,
            refrashRate: refreshRateTextField.text
        )
        let modulationViewController = ModulationViewController()
        navigationController?.pushViewController(modulationViewController, animated: true)
    }
    
    private enum LocalizedStrings {
        static let groupSizeTitle = "Group Size"
        static let groupSizeMessage = "Amount of population, more than 1"
        static let infectionFactorTitle = "Infection Factor"
        static let infectionFactorMessage = "From 1 to 8"
        static let refrashRateTitle = "Refresh Rate"
        static let refrashRateMessage = "In seconds, more than 1"
        static let runModulationButton = "Запустить моделирование"
    }
}

// MARK: - Keyboard Handling
extension SettingsViewController {
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.size.height + 48, right: 0)
        rootScroll.contentInset = contentInset
        rootScroll.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        rootScroll.contentInset = .zero
        rootScroll.scrollIndicatorInsets = .zero
    }
}

extension SettingsViewController {
    private func addSubViews() {
        [
            iconLabel,
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
        rootScroll.translatesAutoresizingMaskIntoConstraints = false
        rootScroll.addSubview(rootStack)
        view.addSubview(rootScroll)
        view.backgroundColor = .white
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            rootScroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rootScroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rootScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootScroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            rootStack.leadingAnchor.constraint(equalTo: rootScroll.contentLayoutGuide.leadingAnchor, constant: 16),
            rootStack.trailingAnchor.constraint(equalTo: rootScroll.contentLayoutGuide.trailingAnchor, constant: -16),
            rootStack.topAnchor.constraint(equalTo: rootScroll.contentLayoutGuide.topAnchor, constant: 16),
            rootStack.bottomAnchor.constraint(equalTo: rootScroll.contentLayoutGuide.bottomAnchor, constant: -16),
            rootStack.widthAnchor.constraint(equalTo: rootScroll.frameLayoutGuide.widthAnchor, constant: -32),
            
            iconLabel.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            iconLabel.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),
            
            groupSizeTextField.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            groupSizeTextField.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),
            
            infectionFactorTextField.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            infectionFactorTextField.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),
            
            refreshRateTextField.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            refreshRateTextField.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),
            
            runButton.leadingAnchor.constraint(equalTo: rootStack.leadingAnchor),
            runButton.trailingAnchor.constraint(equalTo: rootStack.trailingAnchor),
            runButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
