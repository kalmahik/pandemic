//
//  ModulationPresenter.swift
//  Pandemic
//
//  Created by kalmahik on 23.03.2024.
//

import Foundation

final class ModulationPresenter {
    private var config: Config
    private var humans: [Human]
    private var timer: Timer?
    weak var view: ModulationViewController?
    
    init(config: Config, timer: Timer? = nil, view: ModulationViewController) {
        self.view = view
        self.config = config
        self.timer = timer
        self.humans = (0..<config.groupSize).map { Human(isSick: false, index: $0) }
    }
    
    func viewDidLoad() {
        view?.addSubViews()
        view?.applyConstraints()
    }
    
    func viewDidDisappear() {
        stopTimer()
    }
    
    func didTapHuman(at index: Int) {
        let indexPaths = [index].map {
            humans[$0].infect()
            return IndexPath(item: $0, section: 0)
        }
        startTimer()
        DispatchQueue.main.async {
            self.view?.updateUI(indexPaths: indexPaths)
        }
    }
    
    func getHumans() -> [Human] {
        humans
    }
    
    private func generateHumans(count: Int) -> [Human] {
        let humans = (0..<config.groupSize).map { Human(isSick: false, index: $0) }
        return humans
    }
    
    private func startTimer() {
        if timer == nil {
            print("TIMER STARTED")
            timer = Timer.scheduledTimer(
                timeInterval: Double(config.refrashRate),
                target: self,
                selector: #selector(calculate),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    private func stopTimer() {
        print("TIMER ENDED")
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func calculate() {
        DispatchQueue.global().async {
            //берем всех здоровых людей
            let allHealthyPeople = self.humans.filter{ !$0.isSick } //too hard i think
            //если здоровых нет - моделяция завершена. Останавливаем таймер
            if allHealthyPeople.isEmpty {
                self.stopTimer()
                return
            }
            //берем всех инфицированных
            let allInfectedPeople = self.humans.filter{ $0.isSick }
            //создаем множество индексов для будушего обновления. Обновляем только здоровых людей и только уникальные записи
            var peopleIndexesToUpdate = Set<Int>()
            for infectedHuman in allInfectedPeople {
                //для каждого инфицированного, мы находим людей кто вокруг
                let peopleNearby = self.getPeopleNearby(around: infectedHuman, peopleInRow: 12)
                //решаем, какое количество человек из этого круга будет заражено
                let amountPeopleIsUnderRisk = Int.random(in: 1...self.config.infectionFactor)
                //берем это количество случайных людей
                let randomPeopleNearby = Array(peopleNearby.shuffled().prefix(amountPeopleIsUnderRisk))
                //заражаем каждого человека из списка выбранных людей
                for randomHuman in randomPeopleNearby {
                    //если выбранный человек уже заражен, пропускаем его и переходим к следующему
                    if randomHuman.isSick { continue }
                    //добавляем человека в список для обновления
                    peopleIndexesToUpdate.insert(randomHuman.index)
                }
            }
            //берем полученный список уникальных "везунчиков"
            let indexPaths = peopleIndexesToUpdate.map {
                //заражаем человека
                self.humans[$0].infect()
                //возвращаем индекс для обновления элемента коллекции
                return IndexPath(item: $0, section: 0)
            }
            //в главном потоке обноваляю юай
            DispatchQueue.main.async {
                self.view?.updateUI(indexPaths: indexPaths)
            }
        }
    }

    private func getPeopleNearby(around human: Human, peopleInRow: Int) -> [Human] {
        let index = human.index
        let isLeftEdgeHuman = index % (peopleInRow) == 0
        let isRightEdgeHuman = (index + 1) % peopleInRow == 0
        var peopleAroundIndexes = [
            index + peopleInRow, //bottom
            index - peopleInRow, //top
        ]
        if !isRightEdgeHuman {
            peopleAroundIndexes.append(index + 1) //right
            peopleAroundIndexes.append(index + 1 - peopleInRow) //top-right
            peopleAroundIndexes.append(index + 1 + peopleInRow) //bottom-right
        }
        if !isLeftEdgeHuman {
            peopleAroundIndexes.append(index - 1) //left
            peopleAroundIndexes.append(index - 1 - peopleInRow) //top-left
            peopleAroundIndexes.append(index - 1 + peopleInRow) //bottom-left
        }
        return peopleAroundIndexes.compactMap { humans.indices.contains($0) ? humans[$0] : nil }
    }
}
