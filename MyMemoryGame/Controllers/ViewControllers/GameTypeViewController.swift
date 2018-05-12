//
//  GameTypeViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/8/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit
import GameKit

class GameTypeViewController: UIViewController, GKGameCenterControllerDelegate {

    // MARK: - Properties
    
    var gcEnabled = Bool()
    var gcDefaultLeaderBoard = String()
    
    // MARK: - Outlets
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var classicButton: UIButton!
    @IBOutlet weak var proButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true

        viewOne.layer.cornerRadius = 15
        viewTwo.layer.cornerRadius = 15
//        classicButton.layer.cornerRadius = 15
//        classicButton.layer.borderColor = UIColor.black.cgColor
//        classicButton.layer.borderWidth = 4.0
//        proButton.layer.cornerRadius = 15
//        proButton.layer.borderColor = UIColor.black.cgColor
//        proButton.layer.borderWidth = 4.0
        authenticateLocalPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Game Center
    
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                
                // 1. Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
                
            } else if (localPlayer.isAuthenticated) {
                
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil { print(error!)
                    } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
                })
                
            } else {
                
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error!)
            }
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func classicGameTapped(_ sender: Any) {
        GameController.shared.gameType = 1
    }
    
    @IBAction func proGameTapped(_ sender: Any) {
        GameController.shared.gameType = 2
    }
    
}
