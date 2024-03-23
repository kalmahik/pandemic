//
//  ModulationViewController.swift
//  Pandemic
//
//  Created by kalmahik on 22.03.2024.
//

import UIKit

final class ModulationViewController: UIViewController {
    
    // MARK: - Public Properties

    var presenter: ModulationPresenter?

    // MARK: - Init
    
    init(config: Config) {
        super.init(nibName: nil, bundle: nil)
        presenter = ModulationPresenter(config: config, view: self)
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
        layout.itemSize = CGSize(width: 48, height: 48)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
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
        guard let human else { return cell}
        cell.configCell(human, index: indexPath.row)
        return cell
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

