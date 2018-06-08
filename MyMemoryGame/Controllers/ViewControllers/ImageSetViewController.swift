//
//  ViewController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/3/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit
import GameKit
import AVFoundation

class ImageSetViewController: UIViewController, GKGameCenterControllerDelegate {

    // MARK: - Properties
    

    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var viewFive: UIView!
    @IBOutlet weak var viewSix: UIView!
    
    @IBOutlet weak var flagButtonOutlet: UIButton!
    @IBOutlet weak var socialMediaButtonOutlet: UIButton!
    @IBOutlet weak var heroButtonOutlet: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        setNavBarTitle()
    }
    
    // MARK: - Functions
    
    func setNavBarTitle() {
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "ArialHebrew-Bold", size: 25)!]
        
        if GameController.shared.gameType == 1 {
            self.navigationItem.title = "CLASSIC"
        } else if GameController.shared.gameType == 2 {
            self.navigationItem.title = "PRO"
        }
    }
    
    func setViews() {
        viewOne.layer.cornerRadius = 15
        viewTwo.layer.cornerRadius = 15
        viewThree.layer.cornerRadius = 15
        viewFour.layer.cornerRadius = 15
        viewFive.layer.cornerRadius = 15
        viewSix.layer.cornerRadius = 15
        
        guard let heroImage = heroButtonOutlet.imageView else { return }
        guard let flagImage = flagButtonOutlet.imageView else { return }
        guard let socialMediaImage = socialMediaButtonOutlet.imageView else { return }
        heroImage.layer.cornerRadius = 10
        flagImage.layer.cornerRadius = 10
        socialMediaImage.layer.cornerRadius = 10
        addNavBarImage()
        addNavBarTwo()
    }
    
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
        NewGameController.shared.soundEffect.play()
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Game Center

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
    
    @IBAction func pokemonImages(_ sender: Any) {
        NewGameController.shared.soundEffect.play()
        GameController.shared.imageType = 1
        NewGameController.shared.imageType = 1
    }
    
    @IBAction func flagImages(_ sender: Any) {
        NewGameController.shared.soundEffect.play()
        GameController.shared.imageType = 2
        NewGameController.shared.imageType = 2
    }
    
    @IBAction func emojiImages(_ sender: Any) {
        NewGameController.shared.soundEffect.play()
        GameController.shared.imageType = 3
        NewGameController.shared.imageType = 3
    }
    
    @IBAction func socialMediaImages(_ sender: Any) {
        NewGameController.shared.soundEffect.play()
        GameController.shared.imageType = 4
        NewGameController.shared.imageType = 4
    }
    
    @IBAction func herosImage(_ sender: Any) {
        NewGameController.shared.soundEffect.play()
        GameController.shared.imageType = 5
        NewGameController.shared.imageType = 5
    }
    
    @IBAction func christmasImages(_ sender: Any) {
        NewGameController.shared.soundEffect.play()
        GameController.shared.imageType = 6
        NewGameController.shared.imageType = 6
    }
    
}
    

