//
//  ModulationViewController.swift
//  Pandemic
//
//  Created by kalmahik on 22.03.2024.
//

import UIKit

final class ModulationViewController: UIViewController, ModulationViewControllerProtocol {
    
    // MARK: - Public Properties
    
    var presenter: ModulationPresenterProtocol?
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = ModulationPresenter(view: self)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        pinchGesture.delegate = self
        collectionView.addGestureRecognizer(pinchGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
    }
    
    // MARK: - Public Methods
    
    @objc func updateUI(indexPaths: [IndexPath]) {
        collectionView.reconfigureItems(at: indexPaths)
        header.updateCount(presenter?.getHealthyPeopleCount(), presenter?.getInfectedPeopleCount())
    }
    
    func getCollectionWidth() -> CGFloat { collectionView.frame.width }
    
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

// MARK: - UICollectionViewDelegate

extension ModulationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didTapHuman(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource

extension ModulationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getPeople().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumanViewCell.identifier, for: indexPath)
        let human = presenter?.getPeople()[indexPath.row]
        guard let humanCell = cell as? HumanViewCell, let human else { return UICollectionViewCell() }
        let imageName = human.isInfected ? "infected" : "healthy"
        humanCell.configCell(imageName: imageName)
        return humanCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ModulationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let presenter else { return CGSize() }
        let size = presenter.getCellWidth()
        return CGSize(width: size, height: size)
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

// MARK: - UIGestureRecognizerDelegate

extension ModulationViewController: UIGestureRecognizerDelegate {
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard sender.view != nil else { return }
        if sender.state == .began || sender.state == .changed {
            presenter?.setScale(sender.scale)
            sender.scale = 1.0
            collectionView.collectionViewLayout.invalidateLayout()
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

