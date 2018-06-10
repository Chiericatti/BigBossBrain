//
//  levelChoiceViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit
import GameKit
import AVFoundation

class DifficultyViewController: UIViewController, GKGameCenterControllerDelegate {

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBarTitle()
    }
    
    // MARK: - Functions
    
    func setButtonsAndViews() {
        viewOne.layer.cornerRadius = 15
        viewTwo.layer.cornerRadius = 15
        viewThree.layer.cornerRadius = 15
        viewFour.layer.cornerRadius = 15
        
        hardButton.layer.cornerRadius = 15

        addNavBarImage()
        addNavBarTwo()
        
    }
    
    func setNavBarTitle() {
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "ArialHebrew-Bold", size: 25)!]
        
        if NewGameController.shared.gameType == 1 {
            self.navigationItem.title = "CLASSIC"
        } else if NewGameController.shared.gameType == 2 {
            self.navigationItem.title = "PRO"
        }
    }
    
    // MARK: - Game Center
    
    func addNavBarImage() {
        
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "icons8-leaderboard-filled-50"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(gameCenterLeaderboard), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
       
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func addNavBarTwo() {
        
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "icons8-left-filled-50"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
   
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    @objc func goBack() {
        NewGameController.shared.cardSoundEffect.play()
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
        NewGameController.shared.cardSoundEffect.play()
        NewGameController.shared.levelMode = 1
    }
    @IBAction func mediumButtonTapped(_ sender: Any) {
        NewGameController.shared.cardSoundEffect.play()
        NewGameController.shared.levelMode = 2
    }
    @IBAction func hardButtonTapped(_ sender: Any) {
        NewGameController.shared.cardSoundEffect.play()
        NewGameController.shared.levelMode = 3
    }
    @IBAction func veryHardButtonTapped(_ sender: Any) {
        NewGameController.shared.cardSoundEffect.play()
        NewGameController.shared.levelMode = 4
    }
}
