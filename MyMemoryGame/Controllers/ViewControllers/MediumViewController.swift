//
//  MediumViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit

class MediumViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var mediumSecondView: UIView!
    
    @IBOutlet var mediumCardButtonsOutlet: [UIButton]!
    
    @IBOutlet weak var restartOutlet: UIBarButtonItem!
    
    @IBOutlet weak var mediumStartButton: UIButton!
    
    // MARK: - Properties
    
    private let dataModel = GameController()
    
    var flipCount = 0 {
        didSet {
            self.navigationItem.title = "FLIPS: \(flipCount/2)"
        }
    }
    
    // MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        dataModel.delegate = self
        
        restartOutlet.isEnabled = false
        let arrayOfButtons = mediumCardButtonsOutlet
        GameController.shared.allButtons = arrayOfButtons
        mediumSecondView.layer.cornerRadius = 15
        mediumSecondView.layer.borderWidth = 5
        mediumSecondView.layer.borderColor = UIColor.black.cgColor
        mediumStartButton.setImage(#imageLiteral(resourceName: "icons8-play-50"), for: .normal)
        mediumStartButton.layer.cornerRadius = mediumStartButton.bounds.size.width / 2
        mediumStartButton.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
       
        guard let allButtons = GameController.shared.allButtons else { return }
        for button in allButtons {
            button.isEnabled = false
            button.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Actions
    
    @IBAction func mediumStartButtonTapped(_ sender: Any) {

        mediumStartButton.isHidden = true
        restartOutlet.isEnabled = true
        guard let allButtons = GameController.shared.allButtons else { return }
        for button in allButtons {
            
            button.isEnabled = true
            button.isHidden = false
        }
        GameController.shared.reloadGame()
    }
    
    @IBAction func mediumRestartButtonTapped(_ sender: Any) {
        
        GameController.shared.reloadGame()
        flipCount = 0
    }
    
    @IBAction func mediumButtonTapped(_ sender: UIButton) {
        
        UIView.transition(with: sender, duration: 0.4, options: .transitionFlipFromRight, animations: nil, completion: nil)
        let card = CardController.shared.cards[sender.tag - 1]
        sender.setImage(UIImage(named: card.cardImageName), for: .normal)
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

extension MediumViewController: DataModelDelegate {
    func didRecieveDataUpdate(data: Int) {
        if data == 8 {
            createVictoryAlert()
            GameController.shared.totalScoreToWin = 0
        }
        print("Data:",data)
    }
}





























