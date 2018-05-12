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
//        hardSecondView.layer.borderWidth = 5
//        hardSecondView.layer.borderColor = UIColor.black.cgColor
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
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "icons8-left-filled-50"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        //set frame
        //button.frame = CGRect(x: 100, y: 10, width: 10, height: 10)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
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
        
        GameController.shared.gameTypeOneButtonsTag.append(sender.tag)
        GameController.shared.gameTypeTwoButtonsTag.append(sender.tag)
        print(GameController.shared.gameTypeOneButtonsTag)
        
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
            GameController.shared.addPointToScoreAndSubmit()
            GameController.shared.reloadGame()
            self.flipCount = 0
            
        }))
        
        present(alert, animated: true)
    }
}

// MARK: - Extensions

extension VeryHardViewController: DataModelDelegate {
    func didRecieveDataUpdate(data: Int) {
        if data == 12 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                GameController.shared.setbackOfImages()
                self.createVictoryAlert()
            }
            GameController.shared.totalScoreToWin = 0
        }
        print("Data:",data)
    }
}







































