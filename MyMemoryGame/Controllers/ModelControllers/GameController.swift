//
//  GameController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/7/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit
import GameKit

protocol DataModelDelegate: class {
    func didRecieveDataUpdate(data: Int)
}

class GameController {
    
    // MARK: - Properties
    
    let LEADERBOARD_ID = "com.score.matchpro"
    
    weak var delegate: DataModelDelegate?

    static let shared = GameController()
    
    var allButtons: [UIButton]?
    
    var score = Score(score: 0)
    
    var randomCardIndex = 0
    var randomImageIndex = 0
    var totalScoreToWin = 0
    
    var gameType = 0
    var imageType = 0
    var levelMode = 0
    
    var arrayToCompare = [String]()
    var arrayToBeUsed = [String]()
    
    var arrayToBeUsedForBackImage = ["myice2-melting-1551367","myice-2-1383840","mygrunge-paint-2-1615296","myplay-with-paint-4-1163287","myultimate-free-photo-1156750","mycoton-texture-1161474"]
    
    var easyDict = [
        1 : ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle"],
        2 : ["_Brazil","_France","_Germany","_Spain","_United-Kingdom","_United-States","_Brazil","_France","_Germany","_Spain","_United-Kingdom","_United-States"],
        
        3 : ["if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_joy","if_cry","if_angry","if_love","if_wink","if_surprise"],
        4 : ["if_YouTube","if_Apple","if_WhatsApp","if_Twitter","if_Snapchat","if_Instagram","if_YouTube","if_Apple","if_WhatsApp","if_Twitter","if_Snapchat","if_Instagram"],
        5 : ["_BATMAN","_Ironman","_Captain_America","_Wolverine","_WONDER_WOMEN","_THE_FLASH","_BATMAN","_Ironman","_Captain_America","_Wolverine","_WONDER_WOMEN","_THE_FLASH"],
        6 : ["_Xmas_Tree","_Stocking","_Snowman","_Present","_Santa","_Reindeer","_Xmas_Tree","_Stocking","_Snowman","_Present","_Santa","_Reindeer"]
    ]
    
    var mediumDict = [
        1 :["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat"],
        2 : ["_Brazil","_France","_Germany","_Spain","_United-Kingdom","_United-States","_Argentina","_Italy","_Brazil","_France","_Germany","_Spain","_United-Kingdom","_United-States","_Argentina","_Italy"],
        3 : ["if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy"],
        4 : ["if_YouTube","if_Apple","if_WhatsApp","if_Twitter","if_Snapchat","if_Instagram","if_Facebook","if_Amazon","if_YouTube","if_Apple","if_WhatsApp","if_Twitter","if_Snapchat","if_Instagram","if_Facebook","if_Amazon"],
        5 : ["_BATMAN","_Ironman","_Captain_America","_Wolverine","_WONDER_WOMEN","_THE_FLASH","_SPIDERMAN","_Green_Lantern","_BATMAN","_Ironman","_Captain_America","_Wolverine","_WONDER_WOMEN","_THE_FLASH","_SPIDERMAN","_Green_Lantern"],
        6 : ["_Xmas_Tree","_Stocking","_Snowman","_Present","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Xmas_Tree","_Stocking","_Snowman","_Present","_Santa","_Reindeer","_Wreath","_Gingerbread_Man"]
    ]
    
    var hardDict = [
        1: ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_rattata","_bellsprout","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_rattata","_bellsprout"],
        2 : ["_Brazil","_France","_Germany","_Spain","_United-Kingdom","_United-States","_Argentina","_Italy","_Canada","_Colombia","_Brazil","_France","_Germany","_Spain","_United-Kingdom","_United-States","_Argentina","_Italy","_Canada","_Colombia"],
        3 : ["if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_sad","if_happy","if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_sad","if_happy"],
        4 : ["if_YouTube","if_Apple","if_WhatsApp","if_Twitter","if_Snapchat","if_Instagram","if_Facebook","if_Amazon","if_Airbnb","if_Skype","if_YouTube","if_Apple","if_WhatsApp","if_Twitter","if_Snapchat","if_Instagram","if_Facebook","if_Amazon","if_Airbnb","if_Skype"],
        5 : ["_BATMAN","_Ironman","_Captain_America","_Wolverine","_WONDER_WOMEN","_THE_FLASH","_SPIDERMAN","_Green_Lantern","_Deadpool","_Black_Widow","_BATMAN","_Ironman","_Captain_America","_Wolverine","_WONDER_WOMEN","_THE_FLASH","_SPIDERMAN","_Green_Lantern","_Deadpool","_Black_Widow"],
        6 : ["_Xmas_Tree","_Stocking","_Snowman","_Present","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Candy_Cane","_Bell","_Xmas_Tree","_Stocking","_Snowman","_Present","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Candy_Cane","_Bell"]
    ]
    
    var veryHardDict =  [
        1 : ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_weedle","_venonat","_rattata","_bellsprout","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_weedle","_venonat","_rattata","_bellsprout"],
        2 :["_Brazil","_France","_Germany","_Spain","_United-Kingdom","_United-States","_Argentina","_Italy","_Canada","_Colombia","_Mexico","_Belgium","_Brazil","_France","_Germany","_Spain","_United-Kingdom","_United-States","_Argentina","_Italy","_Canada","_Colombia","_Mexico","_Belgium"],
        3 : ["if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_sad","if_happy","if_dead","if_embarrass","if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_sad","if_happy","if_dead","if_embarrass"],
        4 : ["if_YouTube","if_Apple","if_WhatsApp","if_Twitter","if_Snapchat","if_Instagram","if_Facebook","if_Amazon","if_Airbnb","if_Skype","if_Github","if_Reddit","if_YouTube","if_Apple","if_WhatsApp","if_Twitter","if_Snapchat","if_Instagram","if_Facebook","if_Amazon","if_Airbnb","if_Skype","if_Github","if_Reddit"],
        5 : ["_BATMAN","_Ironman","_Captain_America","_Wolverine","_WONDER_WOMEN","_THE_FLASH","_SPIDERMAN","_Green_Lantern","_Deadpool","_Black_Widow","_PUNISHER","_Superman","_BATMAN","_Ironman","_Captain_America","_Wolverine","_WONDER_WOMEN","_THE_FLASH","_SPIDERMAN","_Green_Lantern","_Deadpool","_Black_Widow","_PUNISHER","_Superman"],
        6 : ["_Xmas_Tree","_Stocking","_Snowman","_Present","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Candy_Cane","_Bell","_Hat","_NothPole","_Xmas_Tree","_Stocking","_Snowman","_Present","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Candy_Cane","_Bell","_Hat","_NothPole"]
    ]
    
    // MARK: - Delegate Function to pass information

    func requestData() {
        let data = GameController.shared.totalScoreToWin
        delegate?.didRecieveDataUpdate(data: data)
    }
    
    // MARK: - Game Funcations
    
    func setbackOfImages() {
        guard let arrayOfButtons =  allButtons else { return }
        for button in arrayOfButtons {
            
            guard let buttonImage = button.imageView else { return }
            buttonImage.layer.cornerRadius = 15
            button.setImage(UIImage(named: arrayToBeUsedForBackImage[self.randomImageIndex]), for: .normal)
            button.isEnabled = true
            
        }
    }
    
    func compareCards() {
        if arrayToCompare.count == 2 {
            if arrayToCompare[0] == arrayToCompare[1]  {
                arrayToCompare.removeAll()
                totalScoreToWin += 1
                print(totalScoreToWin)
            }
            else if arrayToCompare[0] != arrayToCompare[1] {
                setbackOfImages()
                arrayToCompare.removeAll()
                totalScoreToWin = 0
                print(totalScoreToWin)
            }
        }
    }
    
    func reloadGame() {
        saveData()
        randomImageIndex = Int(arc4random_uniform(UInt32(arrayToBeUsedForBackImage.count)))
        CardController.shared.cards.removeAll()
        randomizeCardImages()
        arrayToCompare.removeAll()
        totalScoreToWin = 0
        
    }
    
    func setImageAndLevel() {
        
        let gameType = (GameController.shared.imageType, GameController.shared.levelMode)
        
        switch gameType {
        case (1,1):
            arrayToBeUsed = easyDict[1]!
        case (1,2):
            arrayToBeUsed = mediumDict[1]!
        case (1,3):
            arrayToBeUsed = hardDict[1]!
        case (1,4):
            arrayToBeUsed = veryHardDict[1]!
        case (2,1):
            arrayToBeUsed = easyDict[2]!
        case (2,2):
            arrayToBeUsed = mediumDict[2]!
        case (2,3):
            arrayToBeUsed = hardDict[2]!
        case (2,4):
            arrayToBeUsed = veryHardDict[2]!
        case (3,1):
            arrayToBeUsed = easyDict[3]!
        case (3,2):
            arrayToBeUsed = mediumDict[3]!
        case (3,3):
            arrayToBeUsed = hardDict[3]!
        case (3,4):
            arrayToBeUsed = veryHardDict[3]!
        case (4,1):
            arrayToBeUsed = easyDict[4]!
        case (4,2):
            arrayToBeUsed = mediumDict[4]!
        case (4,3):
            arrayToBeUsed = hardDict[4]!
        case (4,4):
            arrayToBeUsed = veryHardDict[4]!
        case (5,1):
            arrayToBeUsed = easyDict[5]!
        case (5,2):
            arrayToBeUsed = mediumDict[5]!
        case (5,3):
            arrayToBeUsed = hardDict[5]!
        case (5,4):
            arrayToBeUsed = veryHardDict[5]!
        case (6,1):
            arrayToBeUsed = easyDict[6]!
        case (6,2):
            arrayToBeUsed = mediumDict[6]!
        case (6,3):
            arrayToBeUsed = hardDict[6]!
        case (6,4):
            arrayToBeUsed = veryHardDict[6]!
        default: return
        }
    }
    
    func setTimerForBackOfImages() {
        switch levelMode {
        case 1:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.setbackOfImages()
            }
        case 2:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                self.setbackOfImages()
            }
        case 3:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                self.setbackOfImages()
            }
        case 4:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                self.setbackOfImages()
            }
        default: return
        }
    }
    
    // MARK: - Randomize func
    
    func randomizeCardImages() {
        
        setImageAndLevel()

        while arrayToBeUsed.count != 0 {
            guard let mediumAllButtons = allButtons else { return }
            for button in mediumAllButtons {
                randomCardIndex = Int(arc4random_uniform(UInt32(arrayToBeUsed.count)))
                CardController.shared.createNewCardWith(cardImageName: arrayToBeUsed[randomCardIndex])
                print(self.arrayToBeUsed[self.randomCardIndex])
                button.setImage(UIImage(named: self.arrayToBeUsed[self.randomCardIndex]), for: .normal)
                guard let buttonImage = button.imageView else { return }
                buttonImage.layer.cornerRadius = 15
//                button.backgroundColor = UIColor.lightGray
                
//                if self.arrayToBeUsed[self.randomCardIndex] == "Brazil" {
//                    button.backgroundColor = UIColor.red
//                } else if self.arrayToBeUsed[self.randomCardIndex] == "EUA" {
//                    button.backgroundColor = UIColor.orange
//                } else if self.arrayToBeUsed[self.randomCardIndex] == "Belgica" {
//                    button.backgroundColor = UIColor.purple
//                } else if self.arrayToBeUsed[self.randomCardIndex] == "Italia" {
//                    button.backgroundColor = UIColor.white
//                } else if self.arrayToBeUsed[self.randomCardIndex] == "Portugal" {
//                    button.backgroundColor = UIColor.green
//                } else if self.arrayToBeUsed[self.randomCardIndex] == "France" {
//                    button.backgroundColor = UIColor.blue
//                }
                button.layer.cornerRadius = 15
                button.layer.borderWidth = 2.0
                button.layer.borderColor = UIColor.black.cgColor

                setTimerForBackOfImages()
                arrayToBeUsed.remove(at: self.randomCardIndex)
            }
        }
    }
    
    // MARK: - Game Center
    
    func addPointToScoreAndSubmit() {
        GameController.shared.score.score += 1
        let myNewScore = GKScore(leaderboardIdentifier: GameController.shared.LEADERBOARD_ID)
        
        myNewScore.value = Int64(GameController.shared.score.score)
        
        GKScore.report([myNewScore]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("New Score submitted to your Leaderboard!")
                print("GameController score:",GameController.shared.score.score)
            }
        }
    }
    
    // MARK: - Save to persistence
    
    func fileURL() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fullURL = path.appendingPathComponent("game").appendingPathExtension("json")
        return fullURL
        
    }
    
    func saveData() {
        do {
            let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(GameController.shared.score)
            try data.write(to: fileURL())
        } catch {
            print(error)
        }
    }
    
    func load() -> Score {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let score = try jsonDecoder.decode(Score.self, from: data)
            return score
        } catch {
            print(error)
        }
        return Score(score: 0)
    }
    
    init() {
        self.score = load()
    }
}




















