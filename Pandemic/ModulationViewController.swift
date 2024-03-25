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
    var scale: CGFloat = 1
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = ModulationPresenter(view: self)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
    }
    
    // MARK: - Public Methods
    
    @objc func updateUI(indexPaths: [IndexPath]) {
        collectionView.reconfigureItems(at: indexPaths)
        header.updateCount(presenter?.getHealthyPeopleCount(), presenter?.getInfectedPeopleCount())
    }
    
    // MARK: - Private Methods
    
    private lazy var header: InformationTable = {
        let header = InformationTable(
            healthyCount: presenter?.getHealthyPeopleCount(),
            infectedCount: presenter?.getInfectedPeopleCount()
        )
        return header
    }()
    
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
        return presenter?.getPeople().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumanViewCell.identifier, for: indexPath)
        let human = presenter?.getPeople()[indexPath.row]
        guard let humanCell = cell as? HumanViewCell, let human else { return UICollectionViewCell() }
        humanCell.configCell(human, index: indexPath.row, size: Constants.humanSize * scale)
        return humanCell
    }
}

extension ModulationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let numberOfColumns = Int(collectionViewWidth / (Constants.humanSize * scale))
        let itemWidth = collectionViewWidth / CGFloat(numberOfColumns)
        columnCount = numberOfColumns
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat { return 0 }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat { return 0 }
}

extension ModulationViewController: UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        let pinchGesture = UIPinchGestureRecognizer(
            target: self,
            action: #selector(handlePinch(_:))
        )
        pinchGesture.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard sender.view != nil else { return }
        if sender.state == .began || sender.state == .changed {
            scale *= sender.scale
            sender.scale = 1.0
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.reloadData()
        }
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool { true }
}

extension ModulationViewController {
    func addSubViews() {
        view.backgroundColor = .white
        view.addSubview(header)
        view.addSubview(collectionView)
        header.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 48),
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

