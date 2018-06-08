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
    
    static let shared = GameController()
    
    let classicLeaderboard = "com.score.classicLeaderboard"
    let proLeaderboard = "com.score.proLeaderboard"
    let trophyLeaderboard = "com.score.matchprotrophies"
    let totalPointsLeaderboad = "com.score.totalPoints"
    
    weak var delegate: DataModelDelegate?

    var allButtons: [UIButton]?
    
    var trophy = Trophy(classicEasy: 0, classicMedium: 0, classicHard: 0, classicVeryHard: 0, proEasy: 0, proMedium: 0, proHard: 0, proVeryHard: 0)
    var score = Score(points: 0, trophies: 0, classic: 0, professional: 0)
    
    var gameTypeOneButtonsTag = [Int]()
    var gameTypeTwoButtonsTag = [Int]()
    
    var arrayToCompare = [String]()
    var arrayToBeUsed = [String]()
    
    var justWonTrophy = 0
    var randomCardIndex = 0
    var randomImageIndex = 0
    var totalScoreToWin = 0
    var gameType = 0
    var imageType = 0
    var levelMode = 0
    
    
    var randomAlertTitlePro = ""
    var randomAlertTitleClassic = ""
    var randomAlertActionName = ""
    
    var arrayOfAlertTitlesClssic = ["That's GREAT!!","WELL DONE!!","GOOD WORK!!","GREAT JOB!!","You're doing GREAT!!","WAY TO GO!!","NICE WORK!!","NICE JOB!!","WONDERFUL!!","IMPRESSIVE!!","AWESOME!!","BRAVO!!"]
    var arrayOfAlertTitlesProfessional = ["Professional as usual!!","You are FANTASTIC!!","Don't EVER leave us!!","FIRST CLASS JOB!!","MAGNIFICENT!!","Bravo!! Bravo!! Bravo!!","PERFECTION!!","AMAZING!!","UNREAL!!","You always amaze me!!","What a STAR!!","TERRIFIC!!","You're one of a kind!!","INCREDIBLE!!","You are a LEGEND!!"]
    
    var arrayOfAlertActions = ["YES","OKEY","YEA","OKEY-DOKEY","AYE AYE","ROGER","YUP","RIGHT ON","SURE THING","YESSIR"]
    
    var arrayToBeUsedForBackImage = ["myice2-melting-1551367","mygrunge-paint-2-1615296","myultimate-free-photo-1156750","mycoton-texture-1161474","rainbow-1-1192968","orange-golden-leaf-1194347","water-effect-1197569","falling-gras-1548881"]
    
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

            UIView.transition(with: button, duration: 0.4, options: .transitionFlipFromRight, animations: nil, completion: nil)
            button.setImage(UIImage(named: self.arrayToBeUsedForBackImage[self.randomImageIndex]), for: .normal)
            button.isEnabled = true
        }
    }
    
    func compareCards() {
        if arrayToCompare.count == 2 {
            if arrayToCompare[0] == arrayToCompare[1]  {
                arrayToCompare.removeAll()
                gameTypeOneButtonsTag.removeAll()
                totalScoreToWin += 1
                //                print(totalScoreToWin)
            }
            else if arrayToCompare[0] != arrayToCompare[1] {
                if gameType == 1 {
                    
                    guard let arrayOfTwoButtons = allButtons else { return }
                    for button in arrayOfTwoButtons {
                        
                        if button.tag == self.gameTypeOneButtonsTag[0] || button.tag == self.gameTypeOneButtonsTag[1] {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                UIView.transition(with: button, duration: 0.4, options: .transitionFlipFromRight, animations: nil, completion: nil)
                                button.setImage(UIImage(named: self.arrayToBeUsedForBackImage[self.randomImageIndex]), for: .normal)
                                button.isEnabled = true
                            }
                            
                            button.isEnabled = false
                        }
                    }
                    
                    gameTypeOneButtonsTag.removeAll()
                    
                } else if gameType == 2 {
                    
                    guard let arrayOfButtons2 = allButtons else { return }
                    for button in arrayOfButtons2 {
                        
                        if gameTypeTwoButtonsTag.contains(button.tag) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                UIView.transition(with: button, duration: 0.4, options: .transitionFlipFromRight, animations: nil, completion: nil)
                                button.setImage(UIImage(named: self.arrayToBeUsedForBackImage[self.randomImageIndex]), for: .normal)
                                button.isEnabled = true
                            }
                        }
                    }
                    
                    gameTypeTwoButtonsTag.removeAll()
                    totalScoreToWin = 0
                }
                
                arrayToCompare.removeAll()
                //                print(totalScoreToWin)
            }
        }
    }
    
    func reloadGame() {

        gameTypeOneButtonsTag.removeAll()
        gameTypeTwoButtonsTag.removeAll()
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
    
    // MARK: - Randomize functions
    
    func randomizeCardImages() {
        
        setImageAndLevel()

        randomImageIndex = Int(arc4random_uniform(UInt32(arrayToBeUsedForBackImage.count)))
        
        while arrayToBeUsed.count != 0 {
            guard let mediumAllButtons = allButtons else { return }
            for button in mediumAllButtons {
                randomCardIndex = Int(arc4random_uniform(UInt32(arrayToBeUsed.count)))
                CardController.shared.createNewCardWith(cardImageName: arrayToBeUsed[randomCardIndex])
//                print(self.arrayToBeUsed[self.randomCardIndex])
                button.setImage(UIImage(named: self.arrayToBeUsed[self.randomCardIndex]), for: .normal)
                guard let buttonImage = button.imageView else { return }
                buttonImage.layer.cornerRadius = 12
                button.layer.cornerRadius = 12
                button.backgroundColor = .white
                button.isEnabled = false
                button.adjustsImageWhenDisabled = false
                
                arrayToBeUsed.remove(at: self.randomCardIndex)
            }
        }
        if gameType == 2 {
            
            setTimerForBackOfImages()
        } else {
            setbackOfImages()
        }
    }
    
    func randomizeAlertTitleAndActionName() {
       let randomClassicTitleIndex = Int(arc4random_uniform(UInt32(arrayOfAlertTitlesClssic.count)))
        randomAlertTitleClassic = arrayOfAlertTitlesClssic[randomClassicTitleIndex]
        
        let randomProTitleIndex = Int(arc4random_uniform(UInt32(arrayOfAlertTitlesProfessional.count)))
        randomAlertTitlePro = arrayOfAlertTitlesProfessional[randomProTitleIndex]
        
        let randonActionIndex = Int(arc4random_uniform(UInt32(arrayOfAlertActions.count)))
        randomAlertActionName = arrayOfAlertActions[randonActionIndex]
    }
    
    // MARK: - Ponits function
    
    func settingTotalScore() {
        if gameType == 1 {
            
            if levelMode == 1 {
                GameController.shared.score.points += 1
                GameController.shared.score.classic += 1
                GameController.shared.trophy.classicEasy = 1
                
            } else if levelMode == 2 {
                GameController.shared.score.points += 2
                GameController.shared.score.classic += 2
                GameController.shared.trophy.classicMedium = 1
                
            } else if levelMode == 3 {
                GameController.shared.score.points += 3
                GameController.shared.score.classic += 3
                GameController.shared.trophy.classicHard = 1
               
            } else if levelMode == 4 {
                GameController.shared.score.points += 4
                GameController.shared.score.classic += 4
                GameController.shared.trophy.classicVeryHard = 1
                
            }
        }
        else if gameType == 2 {
            
            if levelMode == 1 {
                GameController.shared.score.points += 2
                GameController.shared.score.professional += 1
                GameController.shared.trophy.proEasy = 1
            } else if levelMode == 2 {
                GameController.shared.score.points += 4
                GameController.shared.score.professional += 2
                GameController.shared.trophy.proMedium = 1
            } else if levelMode == 3 {
                GameController.shared.score.points += 6
                GameController.shared.score.professional += 3
                GameController.shared.trophy.proHard = 1
            } else if levelMode == 4 {
                GameController.shared.score.points += 8
                GameController.shared.score.professional += 4
                GameController.shared.trophy.proVeryHard = 1
            }
        }
//        print("classicEasy:",GameController.shared.trophy.classicEasy)
//        print("classicMedium:",GameController.shared.trophy.classicMedium)
//        print("classicHard:",GameController.shared.trophy.classicHard)
//        print("classicVeryHard:",GameController.shared.trophy.classicVeryHard)
//        print("proEasy:",GameController.shared.trophy.proEasy)
//        print("proMedium:",GameController.shared.trophy.proMedium)
//        print("proHard:",GameController.shared.trophy.proHard)
//        print("proVeryHard:",GameController.shared.trophy.proVeryHard)
        
        checkIfWonTrophy()
        saveData()
    }
    
    func checkIfWonTrophy() {
        
        let wonTrophy = (GameController.shared.trophy.classicEasy,GameController.shared.trophy.classicMedium,GameController.shared.trophy.classicHard,GameController.shared.trophy.classicVeryHard,GameController.shared.trophy.proEasy,GameController.shared.trophy.proMedium,GameController.shared.trophy.proHard,GameController.shared.trophy.proVeryHard)
        
        switch wonTrophy {
        case (1,1,1,1,1,1,1,1):
            GameController.shared.score.trophies += 1
            justWonTrophy = 1
            submitTrophiesToGameCenter()
            
            
        default: return
        }
    }
    
    func resetTrophyOnScore() {
        
        GameController.shared.trophy.classicEasy = 0
        GameController.shared.trophy.classicMedium = 0
        GameController.shared.trophy.classicHard = 0
        GameController.shared.trophy.classicVeryHard = 0
        GameController.shared.trophy.proEasy = 0
        GameController.shared.trophy.proMedium = 0
        GameController.shared.trophy.proHard = 0
        GameController.shared.trophy.proVeryHard = 0
        GameController.shared.justWonTrophy = 0
    }
    
    // MARK: - Game Center
    
    func submmitTotalPointsToGameCenter() {
        
        let myNewPointsScore = GKScore(leaderboardIdentifier: GameController.shared.totalPointsLeaderboad)
        
        myNewPointsScore.value = Int64(GameController.shared.score.points)
        
        GKScore.report([myNewPointsScore]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("New Total point(s) submitted to your Leaderboard!")
                print("GameController Total Points:",GameController.shared.score.points)
            }
        }
        
    }
    
    func submitTrophiesToGameCenter() {
        
        let myNewTrophiesScire = GKScore(leaderboardIdentifier: GameController.shared.trophyLeaderboard)
        
        myNewTrophiesScire.value = Int64(GameController.shared.score.trophies)
        
        GKScore.report([myNewTrophiesScire]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("New Trophy submitted to your Leaderboard!")
                print("GameController Trophies:",GameController.shared.score.trophies)
            }
        }
        
    }
    
    func submitClassicPointsToGameCenter() {
        
        let myNewClassicPoints = GKScore(leaderboardIdentifier: GameController.shared.classicLeaderboard)
        
        myNewClassicPoints.value = Int64(GameController.shared.score.classic)
        
        GKScore.report([myNewClassicPoints]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("New Classic point submitted to your Leaderboard!")
                print("GameController Classic points:",GameController.shared.score.classic)
                
            }
        }
    }
    
    func submitProfessionalPointsToGameCenter() {
        
        let myNewProPoints = GKScore(leaderboardIdentifier: GameController.shared.proLeaderboard)
        
        myNewProPoints.value = Int64(GameController.shared.score.professional)
        
        GKScore.report([myNewProPoints]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("New Professional point submitted to your Leaderboard!")
                print("GameController Pro points:",GameController.shared.score.professional)
                
            }
        }
    }
    
    func submitScoreToGameCenter() {

        settingTotalScore()
        
        submitClassicPointsToGameCenter()
        submitProfessionalPointsToGameCenter()
        submmitTotalPointsToGameCenter()
        
        
    }
    
    // MARK: - Save to persistence
    
    func fileURLScore() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fullURL = path.appendingPathComponent("gameScore").appendingPathExtension("json")
        return fullURL
    }
    
    func fileURLTrophy() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fullURL = path.appendingPathComponent("gameTrophy").appendingPathExtension("json")
        return fullURL
    }
    
    func saveData() {
        do {
            let jsonEncoder = JSONEncoder()
            let dataScore = try jsonEncoder.encode(GameController.shared.score)
            let dataTrophy = try jsonEncoder.encode(GameController.shared.trophy)
            try dataScore.write(to: fileURLScore())
            try dataTrophy.write(to: fileURLTrophy())
        } catch {
            print(error)
        }
    }
    
    func load() -> (Score, Trophy) {
        let jsonDecoder = JSONDecoder()
        do {
            let dataScore = try Data(contentsOf: fileURLScore())
            let dataTrophy = try Data(contentsOf: fileURLTrophy())
            let score = try jsonDecoder.decode(Score.self, from: dataScore)
            let trophy = try jsonDecoder.decode(Trophy.self, from: dataTrophy)
            return (score, trophy)
        } catch {
            print(error)
        }
        return (Score(points: 0, trophies: 0, classic: 0, professional: 0),Trophy(classicEasy: 0, classicMedium: 0, classicHard: 0, classicVeryHard: 0, proEasy: 0, proMedium: 0, proHard: 0, proVeryHard: 0))
    }
    
    init() {
        self.score = load().0
        self.trophy = load().1
    }
}




















