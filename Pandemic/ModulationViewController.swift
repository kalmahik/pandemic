//
//  ModulationViewController.swift
//  Pandemic
//
//  Created by kalmahik on 22.03.2024.
//

import UIKit

final class ModulationViewController: UIViewController {
    
    // MARK: - Public Properties
    let configHelper = ConfigHelper.shared
    var presenter: ModulationPresenter?
    var columnCount: Int?
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = ModulationPresenter(view: self)
    }
    
    // MARK: - UIViewController
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
    }
    
    // MARK: - Public Methods
    
    @objc func updateUI(indexPaths: [IndexPath]) {
        self.collectionView.reconfigureItems(at: indexPaths)
    }
    
    // MARK: - Private Methods
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HumanViewCell.self, forCellWithReuseIdentifier: HumanViewCell.identifier)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
}

extension ModulationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didTapHuman(at: indexPath.row)
    }
}

extension ModulationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getHumans().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumanViewCell.identifier, for: indexPath) as! HumanViewCell
        let human = presenter?.getHumans()[indexPath.row]
        guard let human else { return cell }
        cell.configCell(human, index: indexPath.row, size: configHelper.config.humanSize)
        return cell
    }
}

extension ModulationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let numberOfColumns = Int(collectionViewWidth / (CGFloat(configHelper.config.humanSize)))
        let itemWidth = collectionViewWidth / CGFloat(numberOfColumns)
        columnCount = numberOfColumns
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
}

extension ModulationViewController {
    func addSubViews() {
        view.addSubview(collectionView)
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
}

