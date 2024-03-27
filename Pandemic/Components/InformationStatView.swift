//
//  InformationStatView.swift
//  Pandemic
//
//  Created by kalmahik on 24.03.2024.
//

import UIKit

final class InformationStatView: UIView {
    
    //MARK: - Initializers
    
    init(healthyCount: Int?, infectedCount: Int?) {
        super.init(frame: .zero)
        addSubViews()
        applyConstraints()
        updateCount(healthyCount, infectedCount)
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
        healthyCountLabel.text = "😀\n\(healthyCount ?? 0)"
    }
    
    private func updateInfected(_ infectedCount: Int?) {
        infectedCountLabel.text = "🤢\n\(infectedCount ?? 0)"
    }
    
    //MARK: - Views
    
    private lazy var infectedCountLabel: UILabel = { countLabel(color: .green) }()
    
    private lazy var healthyCountLabel: UILabel = { countLabel(color: .yellow) }()
    
    private func countLabel(color: UIColor) -> UILabel {
        let label = UILabel()
        label.backgroundColor = color
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.numberOfLines = 0;
        return label
    }
}

extension InformationStatView {
    private func addSubViews() {
        healthyCountLabel.translatesAutoresizingMaskIntoConstraints = false
        infectedCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(healthyCountLabel)
        addSubview(infectedCountLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            healthyCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            healthyCountLabel.topAnchor.constraint(equalTo: topAnchor),
            healthyCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            healthyCountLabel.widthAnchor.constraint(equalTo: infectedCountLabel.widthAnchor),
            
            infectedCountLabel.topAnchor.constraint(equalTo: topAnchor),
            infectedCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            infectedCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            infectedCountLabel.leadingAnchor.constraint(equalTo: healthyCountLabel.trailingAnchor, constant: 16)
        ])
    }
}

