//
//  InformationTable.swift
//  Pandemic
//
//  Created by kalmahik on 24.03.2024.
//

import UIKit

final class InformationTable: UIView {
    
    //MARK: - Initializers
    
    convenience init(healthyCount: Int?, infectedCount: Int?) {
        self.init()
        addSubViews()
        applyConstraints()
        updateCount(healthyCount, infectedCount)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func updateCount(_ healthyCount: Int?, _ infectedCount: Int?) {
        updateHealthy(healthyCount)
        updateInfected(infectedCount)
    }
    
    //MARK: - Private Methods
    
    private func updateHealthy(_ healthyCount: Int?) {
        healthyCountLabel.text = "😀: \(healthyCount ?? 0)"
    }
    
    private func updateInfected(_ infectedCount: Int?) {
        infectedCountLabel.text = "🤢: \(infectedCount ?? 0)"
    }
    
    //MARK: - Views
    
    private let rootStack: UIStackView =  {
        let rootStack: UIStackView = UIStackView()
        rootStack.axis = NSLayoutConstraint.Axis.horizontal
        rootStack.distribution = UIStackView.Distribution.fill
        rootStack.alignment = UIStackView.Alignment.leading
        rootStack.spacing = 8
        rootStack.layer.borderWidth = 1
        return rootStack
    }()
    
    private lazy var healthyCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var infectionFactorLabel: UILabel = {
        let label = UILabel()
        label.text = "123"
        return label
    }()
    
    private lazy var infectedCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()

}

extension InformationTable {
    private func addSubViews() {[
        healthyCountLabel,
        infectedCountLabel,
        infectionFactorLabel
    ].forEach {
        $0.translatesAutoresizingMaskIntoConstraints = false
        rootStack.translatesAutoresizingMaskIntoConstraints = false
        rootStack.addArrangedSubview($0)
    }
        addSubview(rootStack)
        self.backgroundColor = .red
    }
    
    private func applyConstraints() {
        guard let parent = superview else { return }
        NSLayoutConstraint.activate([
            rootStack.widthAnchor.constraint(equalTo: parent.widthAnchor),
            rootStack.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

