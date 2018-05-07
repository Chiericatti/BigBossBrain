//
//  levelChoiceViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit

class levelChoiceViewController: UIViewController {


    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateBackground()
    }

    func animateBackground() {
        UIView.animate(withDuration: 20, delay: 0, options: [.curveLinear, .autoreverse, .repeat], animations: {
            let x = -(self.backgroundImageView.frame.width - self.view.frame.width)
            self.backgroundImageView.transform = CGAffineTransform(translationX: x, y: 0)
        }) { (success) in
            
        }
    }

    @IBAction func easyButtonTapped(_ sender: Any) {
        GameController.shared.levelMode = 1
        
        print(GameController.shared.levelMode)
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
