//
//  MediumViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit

class MediumViewController: UIViewController {

    @IBOutlet weak var mediumSecondView: UIView!
    
    @IBOutlet var mediumCardButtonsOutlet: [UIButton]!
    
    @IBOutlet weak var restartOutlet: UIBarButtonItem!
    
    @IBOutlet weak var mediumStartButton: UIButton!
    
    
    
    var flipCount = 0 {
        didSet {
            self.navigationItem.title = "FLIPS: \(flipCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartOutlet.isEnabled = false
        let arrayOfButtons = mediumCardButtonsOutlet
        GameController.shared.allButtons = arrayOfButtons
        mediumSecondView.layer.cornerRadius = 12
        mediumStartButton.setImage(#imageLiteral(resourceName: "icons8-play-50"), for: .normal)
        mediumStartButton.layer.cornerRadius = mediumStartButton.bounds.size.width / 2
        mediumStartButton.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
       
        
        guard let allButtons = GameController.shared.allButtons else { return }
        for button in allButtons {
            button.isEnabled = false
        }
    }
    
    // MARK: - Actions
    
    @IBAction func mediumStartButtonTapped(_ sender: Any) {

        mediumStartButton.isHidden = true
        restartOutlet.isEnabled = true
        guard let allButtons = GameController.shared.allButtons else { return }
        for button in allButtons {
            button.isEnabled = true
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
        flipCount += 1
    }
}






























