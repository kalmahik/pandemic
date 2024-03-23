//
//  HumanViewCell.swift
//  Pandemic
//
//  Created by kalmahik on 22.03.2024.
//

import UIKit

final class HumanViewCell: UICollectionViewCell {
    
    // MARK: - Constants

    static let identifier = "HumanCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        applyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(_ human: Human, index: Int) {
        humanTextLabel.text = human.isSick ? "🤢" : "😀"
    }
    
    private lazy var humanTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension HumanViewCell {
    private func setupViews() {
        contentView.addSubview(humanTextLabel)
        backgroundColor = UIColor.blue
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            humanTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            humanTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
