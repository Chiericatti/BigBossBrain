//
//  HardViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit

class VeryHardViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var hardSecondView: UIView!
    
    @IBOutlet var cardButtonOutlet: [UIButton]!
    
    @IBOutlet weak var restartOutlet: UIBarButtonItem!
    
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Properties
    
    private let dataModel = GameController()
    
    var flipCount = 0 {
        didSet {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Arial Hebrew", size: 30)!]
            self.navigationItem.title = "FLIPS: \(flipCount/2)"
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        dataModel.delegate = self
        
        restartOutlet.isEnabled = false
        let arrayOFButtons = cardButtonOutlet
        GameController.shared.allButtons = arrayOFButtons
        hardSecondView.layer.cornerRadius = 15
        startButton.setImage(#imageLiteral(resourceName: "icons8-play-filled-50"), for: .normal)
        startButton.layer.cornerRadius = startButton.bounds.size.width / 2
        startButton.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        
        guard let allButtons = GameController.shared.allButtons else { return }
        for button in allButtons {
            button.isEnabled = false
            button.isHidden = true
            button.isExclusiveTouch = true
        }
        addNavBarTwo()
        navigationItem.rightBarButtonItem?.image?.withRenderingMode(.alwaysOriginal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Functions
    
    func addNavBarTwo() {
        
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "icons8-left-filled-50"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Actions
    
    @IBAction func startButtonTapped(_ sender: Any) {
        restartOutlet.isEnabled = true
        startButton.isHidden = true
        guard let allButtons = GameController.shared.allButtons else { return }
        for button in allButtons {

                button.isEnabled = true
                button.isHidden = false

        }
        GameController.shared.reloadGame()
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        
        GameController.shared.reloadGame()
        flipCount = 0
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        UIView.transition(with: sender, duration: 0.4, options: .transitionFlipFromRight, animations: nil, completion: nil)
        let card = CardController.shared.cards[sender.tag - 1]
        sender.setImage(UIImage(named: card.cardImageName), for: .normal)
        
        if GameController.shared.gameType == 1 {
            
            GameController.shared.gameTypeOneButtonsTag.append(sender.tag)
//            print(GameController.shared.gameTypeOneButtonsTag)
            
        } else if GameController.shared.gameType == 2 {
            
            GameController.shared.gameTypeTwoButtonsTag.append(sender.tag)
//            print(GameController.shared.gameTypeTwoButtonsTag)
        }
        
        GameController.shared.arrayToCompare.append(card.cardImageName)
        sender.isEnabled = false
        sender.adjustsImageWhenDisabled = false
        GameController.shared.compareCards()
        dataModel.requestData()
        flipCount += 1
    }
    
    // MARK: - Alert
    
    func createVictoryAlert() {
        
        GameController.shared.randomizeAlertTitleAndActionName()
        
        if GameController.shared.gameType == 1 {
            
            let alert = UIAlertController(title: GameController.shared.randomAlertTitleClassic, message: "- 4 points added to Classic\n - 4 points added to King of Points.", preferredStyle: .alert)
            
            let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
            imageView.image = #imageLiteral(resourceName: "icons8-medal-80")
            alert.view.addSubview(imageView)
            
            alert.addAction(UIAlertAction(title: GameController.shared.randomAlertActionName, style: .default, handler: { (_) in
                
                if GameController.shared.justWonTrophy == 1 {
                    let alert = UIAlertController(title: "BRILLIANT!!!!!\nYou are a Master.", message: "- 1 Trophy added to Big Boss Trophy", preferredStyle: .alert)
                    
                    let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
                    imageView.image = #imageLiteral(resourceName: "icons8-trophy-80")
                    alert.view.addSubview(imageView)
                    
                    alert.addAction(UIAlertAction(title: GameController.shared.randomAlertActionName, style: .default, handler: { (_) in
                        GameController.shared.reloadGame()
                        GameController.shared.resetTrophyOnScore()
                    }))
                    self.present(alert,animated: true)
                }
                
                GameController.shared.reloadGame()
            }))
            present(alert,animated: true)
            
        } else if GameController.shared.gameType == 2 {
            
            let alert = UIAlertController(title: GameController.shared.randomAlertTitlePro, message: "- 4 points added to Professional\n - 8 points added to King of Points.", preferredStyle: .alert)
            
            let imageView = UIImageView(frame: CGRect(x: 225, y: 10, width: 40, height: 40))
            imageView.image = #imageLiteral(resourceName: "icons8-medal-80")
            alert.view.addSubview(imageView)
            
            alert.addAction(UIAlertAction(title: GameController.shared.randomAlertActionName, style: .default, handler: { (_) in
                
                if GameController.shared.justWonTrophy == 1 {
                    let alert = UIAlertController(title: "BRILLIANT!!!!!\nYou are a Master.", message: "- 1 Trophy added to Big Boss Trophy", preferredStyle: .alert)
                    
                    let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
                    imageView.image = #imageLiteral(resourceName: "icons8-trophy-80")
                    alert.view.addSubview(imageView)
                    
                    alert.addAction(UIAlertAction(title: GameController.shared.randomAlertActionName, style: .default, handler: { (_) in
                        GameController.shared.reloadGame()
                        GameController.shared.resetTrophyOnScore()
                    }))
                    self.present(alert,animated: true)
                }
                
                GameController.shared.reloadGame()
            }))
            present(alert,animated: true)
            
        }
        GameController.shared.submitScoreToGameCenter()
        self.flipCount = 0
    }
}

// MARK: - Extensions

extension VeryHardViewController: DataModelDelegate {
    func didRecieveDataUpdate(data: Int) {
        if data == 12 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                
                if GameController.shared.gameType == 2 {
                    
                    GameController.shared.setbackOfImages()
                }
                self.createVictoryAlert()
            }
            GameController.shared.totalScoreToWin = 0
        }
//        print("Data:",data)
    }
}







































