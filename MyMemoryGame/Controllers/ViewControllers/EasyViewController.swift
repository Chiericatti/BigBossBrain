//
//  EasyViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit

class EasyViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var easySecondView: UIView!
    
    @IBOutlet var cardButtonsOutlet: [UIButton]!
    
    @IBOutlet weak var restartOutlet: UIBarButtonItem!
    
    @IBOutlet weak var easyStartButton: UIButton!
    
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
        let arrayOfButtons = cardButtonsOutlet
        GameController.shared.allButtons = arrayOfButtons
        easySecondView.layer.cornerRadius = 15
//        easySecondView.layer.borderWidth = 5
//        easySecondView.layer.borderColor = UIColor.black.cgColor
        easyStartButton.setImage(#imageLiteral(resourceName: "icons8-play-filled-50"), for: .normal)
        easyStartButton.layer.cornerRadius = easyStartButton.bounds.size.width / 2
        easyStartButton.backgroundColor = UIColor(white: 1.0, alpha: 0.5)

        guard let allButtons = GameController.shared.allButtons else { return }
        for button in allButtons {
            button.isEnabled = false
            button.isHidden = true
            button.isExclusiveTouch = true
        }
        
        addNavBarTwo()
//        addNavBarRefresh()
        
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
//
//    let refreshButton: UIBarButtonItem = {
//
//        let button = UIButton(type: UIButtonType.custom)
//        button.setImage(UIImage(named: "icons8-repeat-26"), for: UIControlState.normal)
//
//        var barButton = UIBarButtonItem(customView: button)
//        button.addTarget(self, action: #selector(restartButtonTapped(_:)), for: UIControlEvents.touchUpInside)
//
//
//        
//        return barButton
//
//    }()
    
//    func addNavBarRefresh() {
//
//        let button: UIButton = UIButton(type: UIButtonType.custom)
//
//        button.setImage(UIImage(named: "icons8-repeat-26"), for: UIControlState.normal)
//
//        button.addTarget(self, action: #selector(restartButtonTapped(_:)), for: UIControlEvents.touchUpInside)
//
//
//        let barButton = UIBarButtonItem(customView: button)
//
//         self.navigationItem.rightBarButtonItem = barButton
//
//    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
   
    
    // MARK: - Actions
    
    @IBAction func startButtonTapped(_ sender: Any) {
        
        let button: UIButton = UIButton(type: UIButtonType.custom)
        
        button.setImage(UIImage(named: "icons8-left-filled-50"), for: UIControlState.normal)
        
        button.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        
        
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButton
        
        easyStartButton.isHidden = true
        restartOutlet.isEnabled = true
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
            print(GameController.shared.gameTypeOneButtonsTag)
            
        } else if GameController.shared.gameType == 2 {
            
            GameController.shared.gameTypeTwoButtonsTag.append(sender.tag)
            print(GameController.shared.gameTypeTwoButtonsTag)
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
        
        let alert = UIAlertController(title: "Congrats!! You finished the game.", message: "One point was added to your total score.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            GameController.shared.reloadGame()
            GameController.shared.addPointToScoreAndSubmit()
            self.flipCount = 0
            
        }))
        
        present(alert, animated: true)
    }
}

// MARK: - Extensions

extension EasyViewController: DataModelDelegate {
    func didRecieveDataUpdate(data: Int) {
        if data == 6 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
            GameController.shared.setbackOfImages()
                self.createVictoryAlert()
            }
            GameController.shared.totalScoreToWin = 0
        }
        print("Data:",data)
    }
}



















