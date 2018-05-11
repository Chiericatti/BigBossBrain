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
    
//    var gcEnabled = Bool()
//    var gcDefaultLeaderBoard = String()

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
//        authenticateLocalPlayer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Game Center
    
    
    
    // MARK: - Functions
    
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
        
        
    }
    
    func addNavBarImage() {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "leaderboard-48"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(gameCenterLeaderboard), for: UIControlEvents.touchUpInside)
        //set frame
        //button.frame = CGRect(x: 100, y: 10, width: 10, height: 10)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    // MARK: - Game Center

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc func gameCenterLeaderboard() {
        
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = GameController.shared.LEADERBOARD_ID
        present(gcVC, animated: true, completion: nil)
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
    
}
    

