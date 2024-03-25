//
//  ModulationPresenter.swift
//  Pandemic
//
//  Created by kalmahik on 23.03.2024.
//

import Foundation

final class ModulationPresenter {
    private var configHelper = ConfigHelper.shared
    private var people: [Human]
    private var infectedPeople: [Human] = []
    private var timer: Timer?
    weak var view: ModulationViewController?
    
    init(timer: Timer? = nil, view: ModulationViewController) {
        self.view = view
        self.timer = timer
        self.people = (0..<configHelper.config.groupSize).map { Human(isSick: false, index: $0) }
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
            infectHumanByIndex(index)
            return IndexPath(item: $0, section: 0)
        }
        startTimer()
        DispatchQueue.main.async {
            self.view?.updateUI(indexPaths: indexPaths)
        }
    }
    
    func getPeople() -> [Human] {
        people
    }
    
    func getHealthyPeople() -> Int {
        people.count - infectedPeople.count
    }
    
    func getInfectedPeopleCount() -> Int {
        infectedPeople.count
    }
    
    func infectHumanByIndex(_ index: Int) {
        people[index].infect()
        self.infectedPeople.append(Human(isSick: true, index: index))
    }
    
    private func generatePeople(count: Int) -> [Human] {
        let people = (0..<configHelper.config.groupSize).map { Human(isSick: false, index: $0) }
        return people
    }
    
    private func startTimer() {
        if timer == nil {
            print("TIMER STARTED")
//            infectedPeople = []
            print(infectedPeople.count)
            timer = Timer.scheduledTimer(
                timeInterval: Double(configHelper.config.refrashRate),
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
            //если все больны - моделяция завершена. Останавливаем таймер
            if self.infectedPeople.count == self.people.count {
                self.stopTimer()
                return
            }
            //создаем множество индексов для будушего обновления. Обновляем только здоровых людей и только уникальные записи
            var peopleIndexesToUpdate = Set<Int>()
            //берем всех инфицированных
            for infectedHuman in self.infectedPeople {
                //для каждого инфицированного, мы находим людей кто вокруг
                let peopleNearby = self.getPeopleNearby(around: infectedHuman)
                //решаем, какое количество человек из этого круга будет заражено
                let amountPeopleIsUnderRisk = Int.random(in: 1...self.configHelper.config.infectionFactor)
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
                self.infectHumanByIndex($0)
                //возвращаем индекс для обновления элемента коллекции
                return IndexPath(item: $0, section: 0)
            }
            //в главном потоке обноваляю юай
            DispatchQueue.main.async {
                self.view?.updateUI(indexPaths: indexPaths)
            }
        }
    }

    private func getPeopleNearby(around human: Human) -> [Human] {
        let peopleInRow = self.view?.columnCount ?? 10
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
        return peopleAroundIndexes.compactMap { people.indices.contains($0) ? people[$0] : nil }
    }
}
