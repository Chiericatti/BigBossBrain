//
//  GameTypeViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/8/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit
import GameKit
import AVFoundation

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
        
        NewGameController.shared.createAudio()
        
        self.navigationController?.isNavigationBarHidden = true

        viewOne.layer.cornerRadius = 15
        viewTwo.layer.cornerRadius = 15
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
                
                // 3. Load leaderboards and scores
                
                GKLeaderboard.loadLeaderboards { objects, error in
                    if let e = error {
                        print(e)
                    } else {
                        let leaderboards = objects! as [GKLeaderboard]

                        for leaderboard in leaderboards {

                            leaderboard.loadScores(completionHandler: { (scores, error) in
                                if error == nil {
                                    guard let myLeaderboard = leaderboard.localPlayerScore else { return }
                                    if myLeaderboard.leaderboardIdentifier == "com.score.classicLeaderboard" {
                                        NewGameController.shared.score.classic = Int(myLeaderboard.value)
                                        print("The classic socre is: \(myLeaderboard.value)")
                                    } else if myLeaderboard.leaderboardIdentifier == "com.score.proLeaderboard" {
                                        NewGameController.shared.score.professional = Int(myLeaderboard.value)
                                        print("The pro socre is: \(myLeaderboard.value)")
                                    } else if myLeaderboard.leaderboardIdentifier == "com.score.matchprotrophies"{
                                        NewGameController.shared.score.trophies = Int(myLeaderboard.value)
                                        print("The  trophy socre is: \(myLeaderboard.value)")
                                    } else if myLeaderboard.leaderboardIdentifier == "com.score.totalPoints" {
                                        NewGameController.shared.score.points = Int(myLeaderboard.value)
                                        print("The  total socre is: \(myLeaderboard.value)")
                                    }
                                }
                            })
                        }
                    }
                }
                
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
        NewGameController.shared.cardSoundEffect.play()
        NewGameController.shared.gameType = 1
    }
    
    @IBAction func proGameTapped(_ sender: Any) {
        NewGameController.shared.cardSoundEffect.play()
        NewGameController.shared.gameType = 2
    }
    
}
