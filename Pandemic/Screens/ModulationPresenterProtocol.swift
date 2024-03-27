//
//  ModulationPresenterProtocol.swift
//  Pandemic
//
//  Created by kalmahik on 27.03.2024.
//

import Foundation

protocol ModulationPresenterProtocol: AnyObject {
    var view: ModulationViewControllerProtocol? { get set }
    var people: [Human] { get }
    var infectedPeople: [Human] { get set }
    var timer: Timer? { get set }
    var columnCount: Int { get set }
    var scale: CGFloat { get set }
    
    func viewDidLoad()
    func viewDidDisappear()
    func didTapHuman(at index: Int)
    func getPeople() -> [Human]
    func getHealthyPeopleCount() -> Int
    func getInfectedPeopleCount() -> Int
    func infectHumanByIndex(_ index: Int)
    func getHelper() -> ConfigHelper
    func getScale() -> CGFloat
    func getCellWidth() -> CGFloat
    func setScale(_ scale: CGFloat)
}
