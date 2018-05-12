//
//  levelChoiceViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit
import GameKit

class levelChoiceViewController: UIViewController, GKGameCenterControllerDelegate {

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
//        hardButton.layer.borderColor = UIColor.black.cgColor
//        hardButton.layer.borderWidth = 3.0
//        easyButton.layer.cornerRadius = 15
//        easyButton.layer.borderColor = UIColor.black.cgColor
//        easyButton.layer.borderWidth = 3.0
//        expertButton.layer.cornerRadius = 15
//        expertButton.layer.borderColor = UIColor.black.cgColor
//        expertButton.layer.borderWidth = 3.0
//        mediumButton.layer.cornerRadius = 15
//        mediumButton.layer.borderColor = UIColor.black.cgColor
//        mediumButton.layer.borderWidth = 3.0
//        
        addNavBarImage()
        addNavBarTwo()
    }

    // MARK: - Game Center
    
    func addNavBarImage() {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "icons8-leaderboard-filled-50"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(gameCenterLeaderboard), for: UIControlEvents.touchUpInside)
        //set frame
        //button.frame = CGRect(x: 100, y: 10, width: 10, height: 10)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    
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
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc func gameCenterLeaderboard() {
        
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        if localPlayer.isAuthenticated {
            
            let gcVC = GKGameCenterViewController()
            gcVC.gameCenterDelegate = self
            gcVC.viewState = .leaderboards
            gcVC.leaderboardIdentifier = GameController.shared.LEADERBOARD_ID
            present(gcVC, animated: true, completion: nil)
        }
        else if localPlayer.isAuthenticated == false {
            
            let alert = UIAlertController(title: "Game Center needs to be enable for leaderboard access.", message: "Please look for Game Center on your phone Settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
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
