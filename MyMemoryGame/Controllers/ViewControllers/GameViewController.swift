//
//  GameCollectionViewController.swift
//  BigBossBrain
//
//  Created by Pedro Henrique Chiericatti on 6/5/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    var flipCount = 0 {
        didSet {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Arial Hebrew", size: 30)!]
            self.navigationItem.title = "FLIPS: \(flipCount/2)"
        }
    }
    
    private let dataModel = NewGameController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var restartButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var backgroundView: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataModel.delegate = self
    
        middleView.layer.cornerRadius = 15
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Arial Hebrew", size: 30)!]
        self.navigationItem.title = "FLIPS: \(0)"
        setViewCollors()
        addBackArrowImageToNavBar()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView!.collectionViewLayout = self.getLayout()
        NewGameController.shared.loadGame()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NewGameController.shared.cardsReadyToUse.removeAll()
    }

    // MARK: - Actions
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        
        collectionView.reloadData()
        NewGameController.shared.loadGame()
        
        self.flipCount = 0
        
        if NewGameController.shared.gameType == 2 {
            NewGameController.shared.cardSoundEffect.play()
        }
    }
    
    // MARK: UICollectionViewDataSource

    func getLayout() -> UICollectionViewLayout {
        
        let layout:UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 62.5, height: 65)
        
        switch NewGameController.shared.levelMode {
        case 1:
            layout.sectionInset = UIEdgeInsets(top: 132, left: 0, bottom: 0, right: 0)
        case 2:
            layout.sectionInset = UIEdgeInsets(top: 92, left: 0, bottom: 0, right: 0)
        case 3:
            layout.sectionInset = UIEdgeInsets(top: 52, left: 0, bottom: 0, right: 0)
        case 4:
            layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        default:
            break
        }
    
        return layout as UICollectionViewLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return NewGameController.shared.setNumberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        NewGameController.shared.allCells.append(cell)
        
        cell.layer.cornerRadius = 10
        
        if NewGameController.shared.gameType == 1 {
            
            cell.backgroundColor = .clear
            cell.cardImage.image = nil
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1) {
                NewGameController.shared.setBackOfAllCards()
            }
            
        } else if NewGameController.shared.gameType == 2 {
            
            cell.cardImage.image = UIImage(named: NewGameController.shared.cardsReadyToUse[indexPath.item])
            NewGameController.shared.timerForSettingBackOfAllCards()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        cell.backgroundColor = .white
        
        let cellImageName = NewGameController.shared.cardsReadyToUse[indexPath.item]
        
        if NewGameController.shared.indexesOfSelectedCells.contains(indexPath.item) || NewGameController.shared.matchedImageNames.contains(cellImageName) || NewGameController.shared.indexesOfSelectedCells.count == 2 {
            
//            print(cellImageName," : Already selected")
        }
        else {
            
            NewGameController.shared.cardSoundEffect.play()
            
            flipCount += 1
            
            NewGameController.shared.indexesOfSelectedCells.append(indexPath.item)
            
            UIView.transition(with: collectionView.cellForItem(at: indexPath)!, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
           
//            print("indexes in indexesOfSelectedCells: ",NewGameController.shared.indexesOfSelectedCells)
            
            if NewGameController.shared.gameType == 1 {
                
                NewGameController.shared.classicSelectedCells.append(cell)
                
            } else {
                
                NewGameController.shared.professionalSelectedCells.append(cell)
            }
            
//            print("The arrayOfCells has this many items: \(NewGameController.shared.classicSelectedCells.count)")
            
            cell.cardImage.image = UIImage(named: cellImageName)
            NewGameController.shared.cellImageToCompare.append(cellImageName)
//            print(cellImageName," : Added to cellImageToCompare")
            
            NewGameController.shared.compareCards()
            dataModel.requestData()
        }
    }
    

    // MARK: - Creatting Button
    
    func addBackArrowImageToNavBar() {
        
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "icons8-left-filled-50"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func goBack() {
        NewGameController.shared.cardSoundEffect.play()
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Setting view collors
    
    func setViewCollors() {
        
        collectionView.backgroundColor = .clear
        
        switch NewGameController.shared.levelMode {
        case 1:
            backgroundView.backgroundColor = UIColor(red: 255/255, green: 114/225, blue: 69/255, alpha: 1)
            middleView.backgroundColor = UIColor(red: 255/255, green: 224/255, blue: 163/255, alpha: 1)
        case 2:
            backgroundView.backgroundColor = UIColor(red: 0/255, green: 106/225, blue: 219/255, alpha: 1)
            middleView.backgroundColor = UIColor(red: 158/255, green: 230/255, blue: 255/255, alpha: 1)
        case 3:
            backgroundView.backgroundColor = UIColor(red: 0/255, green: 175/225, blue: 1/255, alpha: 1)
            middleView.backgroundColor = UIColor(red: 212/255, green: 236/255, blue: 198/255, alpha: 1)
        case 4:
            backgroundView.backgroundColor = UIColor(red: 178/255, green: 67/225, blue: 255/255, alpha: 1)
            middleView.backgroundColor = UIColor(red: 236/255, green: 206/255, blue: 226/255, alpha: 1)
        default:
            return
        }
    }
    
    // MARK: - Alerts
    
    func createTrophyAlert(completion: @escaping(Bool) -> Void) {
        
        if NewGameController.shared.justWonTrophy == 1 {
            
            let alert = UIAlertController(title: "BRILLIANT!!\nYou are a Master.", message: "- 1 Trophy added to Big Boss Trophy for completing all difficulty levels for Classic and Professional mode. ", preferredStyle: .alert)
            
            let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
            imageView.image = #imageLiteral(resourceName: "icons8-trophy-80")
            alert.view.addSubview(imageView)
            
            alert.addAction(UIAlertAction(title: NewGameController.shared.randomAlertActionName, style: .default, handler: { (_) in
                
                self.collectionView.reloadData()
                NewGameController.shared.loadGame()
            }))
            NewGameController.shared.resetTrophyOnScore()
            NewGameController.shared.trophySoundEffect.play()
            present(alert,animated: true)
            completion(true)
            return
        }
        
        completion(false)
        return
    }
    
    func createVictoryAlert() {
        
        NewGameController.shared.randomizeAlertTitleAndActionName()
        
        if NewGameController.shared.gameType == 1 {
            
            let message = setClassicMessage()
            
            let alert = UIAlertController(title: NewGameController.shared.randomAlertTitleClassic, message: message, preferredStyle: .alert)
            
            let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
            imageView.image = #imageLiteral(resourceName: "icons8-medal-80")
            alert.view.addSubview(imageView)
            
            alert.addAction(UIAlertAction(title: NewGameController.shared.randomAlertActionName, style: .default, handler: { (_) in
                
                self.createTrophyAlert(completion: { (success) in
                    
                    if !success {
                        self.collectionView.reloadData()
                        NewGameController.shared.loadGame()
                        NewGameController.shared.cardSoundEffect.play()
                    }
                })
            }))
            NewGameController.shared.gameWinSoundEffect.play()
            present(alert,animated: true)
            
        } else if NewGameController.shared.gameType == 2 {
            
            let message = setProfessionalMessage()
            
            let alert = UIAlertController(title: NewGameController.shared.randomAlertTitlePro, message: message, preferredStyle: .alert)
            
            let imageView = UIImageView(frame: CGRect(x: 225, y: 10, width: 40, height: 40))
            imageView.image = #imageLiteral(resourceName: "icons8-medal-80")
            alert.view.addSubview(imageView)
            
            alert.addAction(UIAlertAction(title: NewGameController.shared.randomAlertActionName, style: .default, handler: { (_) in
                
                self.createTrophyAlert(completion: { (success) in
                    
                    if !success {
                        self.collectionView.reloadData()
                        NewGameController.shared.loadGame()
                        NewGameController.shared.cardSoundEffect.play()
                    }
                })
                
            }))
            NewGameController.shared.gameWinSoundEffect.play()
            present(alert,animated: true)
        }
        
        NewGameController.shared.submitScoreToGameCenter()
        self.flipCount = 0
    }
    
    func setClassicMessage() -> String {
        
        var message = ""
        
        switch NewGameController.shared.levelMode {
        case 1:
            message = "- 1 point added to Classic\n - 1 point added to King of Points."
        case 2:
            message = "- 2 points added to Classic\n - 2 points added to King of Points."
        case 3:
            message = "- 3 points added to Classic\n - 3 points added to King of Points."
        case 4:
            message = "- 4 points added to Classic\n - 4 points added to King of Points."
        default:
            return message
        }
        
        return message
    }
    
    func setProfessionalMessage() -> String {
        
        var message = ""
        
        switch NewGameController.shared.levelMode {
        case 1:
            message = "- 1 point added to Professional\n - 2 points added to King of Points."
        case 2:
            message = "- 2 points added to Professional\n - 4 points added to King of Points."
        case 3:
            message = "- 3 points added to Professional\n - 6 points added to King of Points."
        case 4:
            message = "- 4 points added to Professional\n - 8 points added to King of Points."
        default:
            return message
        }

        return message
    }
}

extension GameViewController: ScoreDataModelDelegate {
    
    func setAlertAndBackOfCards() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            
            if NewGameController.shared.gameType == 2 {
                
                NewGameController.shared.setBackOfAllCards()
            }
            self.createVictoryAlert()
        }
        NewGameController.shared.totalScoreToWin = 0
    }

    func didRecieveDataUpdate(data: Int) {
        
        switch NewGameController.shared.levelMode {
        case 1:
            if data == 6 {
                setAlertAndBackOfCards()
            }
        case 2:
            if data == 8 {
                setAlertAndBackOfCards()
            }
        case 3:
            if data == 10 {
                setAlertAndBackOfCards()
            }
        case 4:
            if data == 12 {
                setAlertAndBackOfCards()
            }
        default:
            return
        }
        print("Data:",data)
    }
}

