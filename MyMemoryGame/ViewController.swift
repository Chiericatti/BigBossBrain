//
//  ViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/3/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    @IBAction func pokemonImages(_ sender: Any) {
        GameController.shared.imageType = 1
    }
    
    @IBAction func flagImages(_ sender: Any) {
        GameController.shared.imageType = 2
    }
    
    @IBAction func emojiImages(_ sender: Any) {
        GameController.shared.imageType = 3
    }
    
    @IBAction func socialMediaImages(_ sender: Any) {
        GameController.shared.imageType = 4
    }
    
    @IBAction func herosImage(_ sender: Any) {
        GameController.shared.imageType = 5
    }
    
    @IBAction func christmasImages(_ sender: Any) {
        GameController.shared.imageType = 6
    }
    
}

