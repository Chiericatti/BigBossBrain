//
//  EasyViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit
import AVFoundation

class EasyViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var easySecondView: UIView!
    
    @IBOutlet var cardButtonsOutlet: [UIButton]!
    
    @IBOutlet weak var restartOutlet: UIBarButtonItem!
    
    @IBOutlet weak var easyStartButton: UIButton!
    
    // MARK: - Properties
    
    private let dataModel = GameController()
    
    var soundEffect: AVAudioPlayer = AVAudioPlayer()
    
    var flipCount = 0 {
        didSet {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Arial Hebrew", size: 30)!]
            self.navigationItem.title = "FLIPS: \(flipCount/2)"
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let soundFile = Bundle.main.path(forResource: "cardSound", ofType: ".mp3")
        
        do {
            soundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: soundFile!))
            soundEffect.prepareToPlay()
        } catch {
            print(error)
        }
        
        self.navigationController?.isNavigationBarHidden = false

        dataModel.delegate = self
        
        restartOutlet.isEnabled = false
        let arrayOfButtons = cardButtonsOutlet
        GameController.shared.allButtons = arrayOfButtons
        easySecondView.layer.cornerRadius = 15
        easyStartButton.setImage(#imageLiteral(resourceName: "icons8-play-filled-50"), for: .normal)
        easyStartButton.layer.cornerRadius = easyStartButton.bounds.size.width / 2
        easyStartButton.backgroundColor = UIColor(white: 1.0, alpha: 0.5)

        guard let allButtons = GameController.shared.allButtons else { return }
        for button in allButtons {
            button.isEnabled = false
            button.isHidden = true
            button.isExclusiveTouch = true
        }
        addBackArrowImageToNavBar()
        navigationItem.rightBarButtonItem?.image?.withRenderingMode(.alwaysOriginal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Functions
    
    func addBackArrowImageToNavBar() {

        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "icons8-left-filled-50"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)

        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func goBack() {
        self.soundEffect.play()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func startButtonTapped(_ sender: Any) {
        
        
        easyStartButton.isHidden = true
        restartOutlet.isEnabled = true
        guard let allButtons = GameController.shared.allButtons else { return }
        for button in allButtons {

                button.isEnabled = true
                button.isHidden = false
        }
        GameController.shared.reloadGame()
        soundEffect.play()
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
       
        GameController.shared.reloadGame()
        flipCount = 0
        soundEffect.play()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        soundEffect.play()
        
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
            
            let alert = UIAlertController(title: GameController.shared.randomAlertTitleClassic, message: "- 1 point added to Classic\n - 1 point added to King of Points.", preferredStyle: .alert)
            
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
                        self.soundEffect.play()
                        GameController.shared.resetTrophyOnScore()
                    }))
                    self.present(alert,animated: true)
                }
                
                GameController.shared.reloadGame()
                self.soundEffect.play()
            }))
            present(alert,animated: true)
            
        } else if GameController.shared.gameType == 2 {
            
            let alert = UIAlertController(title: GameController.shared.randomAlertTitlePro, message: "- 1 point added to Professional\n - 2 points added to King of Points.", preferredStyle: .alert)
            
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
                        self.soundEffect.play()
                        GameController.shared.resetTrophyOnScore()
                    }))
                    self.present(alert,animated: true)
                }
                GameController.shared.reloadGame()
                self.soundEffect.play()
            }))
            present(alert,animated: true)
        }
    
        GameController.shared.submitScoreToGameCenter()
        self.flipCount = 0
    }
}

// MARK: - Extensions

extension EasyViewController: DataModelDelegate {
    func didRecieveDataUpdate(data: Int) {
        if data == 6 {
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



















