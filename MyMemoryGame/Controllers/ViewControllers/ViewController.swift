//
//  ViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/3/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, GKGameCenterControllerDelegate {

    // MARK: - Properties
    
    var gcEnabled = Bool()
    var gcDefaultLeaderBoard = String()

    // MARK: - Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var viewFive: UIView!
    @IBOutlet weak var viewSix: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        authenticateLocalPlayer()
        
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
    
    // MARK: - Functions
    
    func setViews() {
        viewOne.layer.cornerRadius = 15
        viewTwo.layer.cornerRadius = 15
        viewThree.layer.cornerRadius = 15
        viewFour.layer.cornerRadius = 15
        viewFive.layer.cornerRadius = 15
        viewSix.layer.cornerRadius = 15
    }
    
    // MARK: - Actions
    
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
    
    // MARK: - Game Center Actions
    
    @IBAction func gameCenter(_ sender: Any) {
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = GameController.shared.LEADERBOARD_ID
        present(gcVC, animated: true, completion: nil)
    }
}

