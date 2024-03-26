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
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        applyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configCell(imageName: String) {
        humanImage.image = UIImage(named: imageName)
    }
    
    // MARK: - Private Methods

    private lazy var humanImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
}

extension HumanViewCell {
    private func setupViews() {
        contentView.addSubview(humanImage)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            humanImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            humanImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            humanImage.topAnchor.constraint(equalTo: topAnchor),
            humanImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
