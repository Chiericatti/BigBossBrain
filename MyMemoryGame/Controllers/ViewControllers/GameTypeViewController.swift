//
//  GameTypeViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/8/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit

class GameTypeViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var classicButton: UIButton!
    @IBOutlet weak var proButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewOne.layer.cornerRadius = 15
        viewTwo.layer.cornerRadius = 15
        classicButton.layer.cornerRadius = 15
        classicButton.layer.borderColor = UIColor.black.cgColor
        classicButton.layer.borderWidth = 4.0
        proButton.layer.cornerRadius = 15
        proButton.layer.borderColor = UIColor.black.cgColor
        proButton.layer.borderWidth = 4.0
    }

    // MARK: - Actions
    
    @IBAction func classicGameTapped(_ sender: Any) {
        GameController.shared.gameType = 1
    }
    
    @IBAction func proGameTapped(_ sender: Any) {
        GameController.shared.gameType = 2
    }
    
}
