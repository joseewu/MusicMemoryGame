//
//  MainViewController.swift
//  MusicMemoryGame
//
//  Created by joseewu on 2018/3/19.
//  Copyright © 2018年 com.nietzsche. All rights reserved.
//

import UIKit
enum MatchStatus {
    case match
    case inconsistent
}
class MainViewController: UIViewController {
    static private let cellIdentifier:String = "cellIdentifier"
    private let start:UIButton = UIButton()
    private var tilesView:UICollectionView!
    private let timerTip:UILabel = UILabel()
    private var direction:UIDeviceOrientation = .portrait
    private var data:[MatchStatus] = [MatchStatus]()
    var answerData = [Int]()
    private var timer:Timer = Timer()
    private var choose:[Bool] = [Bool]()
    private var chooseStorage:[Int] = [Int]()
    private var tilesSize:CGSize {
        set {
            self.tilesSize = newValue
        }
        get {
            switch direction {
            case .portrait:
                let horizontal:CGFloat = 4
                let width = (view.frame.size.width - 40 - (horizontal - 1) * 10)/horizontal
                return CGSize(width: width, height: width)
            default:
                return CGSize(width: 10, height: 10)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        renderUi()
    }
    private func renderUi() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = tilesSize
        tilesView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tilesView.delegate = self
        tilesView.dataSource = self
        tilesView.allowsMultipleSelection = true
        tilesView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: MainViewController.cellIdentifier)
        view.addSubview(tilesView)
        start.setTitle("開始", for: .normal)
        start.setTitle("停止", for: .selected)
        start.titleLabel?.textAlignment = .center
        start.titleLabel?.font = UIFont(name: "", size: 40)
        start.addTarget(self, action: #selector(MainViewController.didPressStart(sender:)), for: .touchUpInside)
        view.addSubview(start)
        timerTip.text = "00:00:00"
        timerTip.textAlignment = .center
        timerTip.font = UIFont(name: "", size: 30)
        view.addSubview(timerTip)
        setConstraints()
        prepareData()
        prepareAnswer()
    }
    func prepareData() {
        for _ in 0 ..< 20 {
            data.append(.inconsistent)
            choose.append(false)
        }
        tilesView.reloadData()
    }
    func prepareAnswer() {
        var tempData = [Int]()
        for _ in 0 ..< 10 {
            var frequency = arc4random_uniform(600) + 400
            while tempData.contains(Int(frequency)) {
                frequency = arc4random_uniform(600) + 400
            }
            tempData.append(Int(frequency))
        }
        for _ in 0 ..< data.count {
            answerData.append(0)
        }
        for i in 0 ..< 10 {
            var pairs = pickRandomNumber()
            while answerData[pairs.0] != 0 || answerData[pairs.1] != 0 {
                pairs = pickRandomNumber()
            }
            answerData[pairs.0] = tempData[i]
            answerData[pairs.1] = tempData[i]
        }
        print(answerData)
    }
    func pickRandomNumber() -> (Int,Int) {
        let randomNumber1 = arc4random_uniform(20)
        var randomNumber2 = arc4random_uniform(20)
        while randomNumber2 == randomNumber1 {
            randomNumber2 = arc4random_uniform(20)
        }
        return (Int(randomNumber1), Int(randomNumber2))
    }
    @objc func didPressStart(sender:UIButton) {
        sortingCard()
    }
    private func sortingCard() {
        var count = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            guard count < self.data.count else {
                timer.invalidate()
                SoundsFactory.shared.stopSound()
                return
            }
            let cell = self.tilesView.cellForItem(at: IndexPath(row: count, section: 0))
            SoundsFactory.shared.playSound(withHz: self.answerData[count])
            cell?.backgroundColor = UIColor.brown
            count += 1
        })
    }
    private func setConstraints() {
        let collectionWidth = view.frame.size.width - 40
        let collectionHight = view.frame.size.height - 40
        tilesView.frame = CGRect(x: 20, y: 120, width: collectionWidth, height:collectionHight)
        start.frame = CGRect(x: view.center.x - 100, y: 30, width: 200, height:60)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        choose[indexPath.row] = true
        chooseStorage.append(indexPath.row)
        assign()
        tilesView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewController.cellIdentifier, for: indexPath)
        let status = data[indexPath.row]
        let choiceMatching = choose[indexPath.row]
        switch status {
        case .inconsistent:
            if choiceMatching {
                cell.backgroundColor = UIColor.red
            } else {
                cell.backgroundColor = UIColor.lightGray
            }
        case .match:
            cell.backgroundColor = UIColor.orange
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    // prevent user deselect the matching car
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    private func assign() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.chooseStorage.count > 1 {
                let first = self.chooseStorage[0]
                let second = self.chooseStorage[1]
                self.choose[first] = false
                self.choose[second] = false
                self.chooseStorage.removeAll()
            }
            self.tilesView.reloadData()
        }
    }
}
