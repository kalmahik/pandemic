//
//  ModulationViewControllerProtocol.swift
//  Pandemic
//
//  Created by kalmahik on 27.03.2024.
//

import Foundation

protocol ModulationViewControllerProtocol: AnyObject {
    var presenter: ModulationPresenterProtocol? { get set }
    
    func viewDidLoad()
    func viewDidDisappear(_ animated: Bool)
    func updateUI(indexPaths: [IndexPath])
    func addSubViews()
    func applyConstraints()
    func getCollectionWidth() -> CGFloat
}
