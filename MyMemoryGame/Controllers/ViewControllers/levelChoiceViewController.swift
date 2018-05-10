//
//  levelChoiceViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit

class levelChoiceViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var expertButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
 
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsAndViews()
    }

    // MARK: - Functions
    
    func setButtonsAndViews() {
        viewOne.layer.cornerRadius = 15
        viewTwo.layer.cornerRadius = 15
        viewThree.layer.cornerRadius = 15
        viewFour.layer.cornerRadius = 15
        
        hardButton.layer.cornerRadius = 15
        hardButton.layer.borderColor = UIColor.black.cgColor
        hardButton.layer.borderWidth = 3.0
        easyButton.layer.cornerRadius = 15
        easyButton.layer.borderColor = UIColor.black.cgColor
        easyButton.layer.borderWidth = 3.0
        expertButton.layer.cornerRadius = 15
        expertButton.layer.borderColor = UIColor.black.cgColor
        expertButton.layer.borderWidth = 3.0
        mediumButton.layer.cornerRadius = 15
        mediumButton.layer.borderColor = UIColor.black.cgColor
        mediumButton.layer.borderWidth = 3.0
    }

    // MARK: - Actions
    
    @IBAction func easyButtonTapped(_ sender: Any) {
        GameController.shared.levelMode = 1
    }
    @IBAction func mediumButtonTapped(_ sender: Any) {
        GameController.shared.levelMode = 2
    }
    @IBAction func hardButtonTapped(_ sender: Any) {
        GameController.shared.levelMode = 3
    }
    @IBAction func veryHardButtonTapped(_ sender: Any) {
        GameController.shared.levelMode = 4
    }
}
