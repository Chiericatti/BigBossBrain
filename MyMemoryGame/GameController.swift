//
//  GameController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/7/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import UIKit


class GameController {
    
    static let shared = GameController()
    
    var imageType = 0
    var levelMode = 0
    var arrayToBeUsed = [String]()
    
    var easyDict = [
        1 : ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle"],
        2 : ["Brazil","EUA","Belgica","Italia","Portugal","France","Brazil","EUA","Belgica","Italia","Portugal","France"],
        3 : ["if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_joy","if_cry","if_angry","if_love","if_wink","if_surprise"],
        4 : ["if_youtube","if_yahoo","if_whatsapp","if_twitter","if_snapchat","if_skype","if_youtube","if_yahoo","if_whatsapp","if_twitter","if_snapchat","if_skype"],
        5 : ["if_JD-28_2624884","if_JD-22_2624865","if_JD-21_2624888","if_JD-20_2624889","if_JD-18_2624890","if_JD-16_2624863","if_JD-28_2624884","if_JD-22_2624865","if_JD-21_2624888","if_JD-20_2624889","if_JD-18_2624890","if_JD-16_2624863"],
        6 : ["_Xmas_Tree","_Stocking","_Snowman","_Snow_Globe","_Santa","_Reindeer","_Xmas_Tree","_Stocking","_Snowman","_Snow_Globe","_Santa","_Reindeer"]
    ]
    
    var mediumDict = [
        1 :["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat"],
        2 : ["Brazil","EUA","Mexico","Italia","Holanda","France","Argentina","Espanha","Brazil","EUA","Mexico","Italia","Holanda","France","Argentina","Espanha"],
        3 : ["if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy"],
        4 : ["if_youtube","if_yahoo","if_whatsapp","if_twitter","if_snapchat","if_skype","if_reddit","if_paypal","if_youtube","if_yahoo","if_whatsapp","if_twitter","if_snapchat","if_skype","if_reddit","if_paypal"],
        5 : ["if_JD-28_2624884","if_JD-22_2624865","if_JD-21_2624888","if_JD-20_2624889","if_JD-18_2624890","if_JD-16_2624863","if_JD-15_2624892","if_JD-09_2624896","if_JD-28_2624884","if_JD-22_2624865","if_JD-21_2624888","if_JD-20_2624889","if_JD-18_2624890","if_JD-16_2624863","if_JD-15_2624892","if_JD-09_2624896"],
        6 : ["_Xmas_Tree","_Stocking","_Snowman","_Snow_Globe","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Xmas_Tree","_Stocking","_Snowman","_Snow_Globe","_Santa","_Reindeer","_Wreath","_Gingerbread_Man"]
    ]
    
    var hardDict = [
        1: ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_rattata","_bellsprout","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_rattata","_bellsprout"],
        2 : ["Brazil","EUA","Mexico","Italia","Holanda","France","Argentina","Espanha","Alemanha","Belgica","Brazil","EUA","Mexico","Italia","Holanda","France","Argentina","Espanha","Alemanha","Belgica"],
        3 : ["if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_sad","if_happy","if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_sad","if_happy"],
        4 : ["if_youtube","if_yahoo","if_whatsapp","if_twitter","if_snapchat","if_skype","if_reddit","if_paypal","if_github","if_facebook","if_youtube","if_yahoo","if_whatsapp","if_twitter","if_snapchat","if_skype","if_reddit","if_paypal","if_github","if_facebook"],
        5 : ["if_JD-28_2624884","if_JD-22_2624865","if_JD-21_2624888","if_JD-20_2624889","if_JD-18_2624890","if_JD-16_2624863","if_JD-15_2624892","if_JD-09_2624896","if_JD-08_2624860","if_JD-14_2624893","if_JD-28_2624884","if_JD-22_2624865","if_JD-21_2624888","if_JD-20_2624889","if_JD-18_2624890","if_JD-16_2624863","if_JD-15_2624892","if_JD-09_2624896","if_JD-08_2624860","if_JD-14_2624893"],
        6 : ["_Xmas_Tree","_Stocking","_Snowman","_Snow_Globe","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Candy_Cane","_Bell","_Xmas_Tree","_Stocking","_Snowman","_Snow_Globe","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Candy_Cane","_Bell"]
    ]
    
    var veryHardDict =  [
        1 : ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_weedle","_venonat","_rattata","_bellsprout","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_weedle","_venonat","_rattata","_bellsprout"],
        2 :["Brazil","EUA","Mexico","Italia","Holanda","France","Argentina","Espanha","Alemanha","Belgica","Colombia","Portugal","Brazil","EUA","Mexico","Italia","Holanda","France","Argentina","Espanha","Alemanha","Belgica","Colombia","Portugal"],
        3 : ["if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_sad","if_happy","if_dead","if_embarrass","if_joy","if_cry","if_angry","if_love","if_wink","if_surprise","if_sleepy","if_shy","if_sad","if_happy","if_dead","if_embarrass"],
        4 : ["if_youtube","if_yahoo","if_whatsapp","if_twitter","if_snapchat","if_skype","if_reddit","if_paypal","if_github","if_facebook","if_evernote","if_amazon","if_youtube","if_yahoo","if_whatsapp","if_twitter","if_snapchat","if_skype","if_reddit","if_paypal","if_github","if_facebook","if_evernote","if_amazon"],
        5 : ["if_JD-28_2624884","if_JD-22_2624865","if_JD-21_2624888","if_JD-20_2624889","if_JD-18_2624890","if_JD-16_2624863","if_JD-15_2624892","if_JD-09_2624896","if_JD-08_2624860","if_JD-14_2624893","if_JD-13_2624862","if_JD-11_2624861","if_JD-28_2624884","if_JD-22_2624865","if_JD-21_2624888","if_JD-20_2624889","if_JD-18_2624890","if_JD-16_2624863","if_JD-15_2624892","if_JD-09_2624896","if_JD-08_2624860","if_JD-14_2624893","if_JD-13_2624862","if_JD-11_2624861"],
        6 : ["_Xmas_Tree","_Stocking","_Snowman","_Snow_Globe","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Candy_Cane","_Bell","_Baubles","_Icicle_","_Xmas_Tree","_Stocking","_Snowman","_Snow_Globe","_Santa","_Reindeer","_Wreath","_Gingerbread_Man","_Candy_Cane","_Bell","_Baubles","_Icicle_"]
    ]
    
    var allButtons: [UIButton]?
    
    var randomCardIndex = 0
    
    var arrayToCompare = [String]()
    
    func setbackOfImages() {
        guard let arrayOfButtons =  allButtons else { return }
        for button in arrayOfButtons {
            button.setImage(#imageLiteral(resourceName: "if_CMYK_1994549"), for: .normal)
            button.isEnabled = true

        }
    }
    
    func compareCards() {
        if arrayToCompare.count == 2 {
            if arrayToCompare[0] == arrayToCompare[1]  {
                arrayToCompare.removeAll()
            }
            else if arrayToCompare[0] != arrayToCompare[1] {
                setbackOfImages()
                arrayToCompare.removeAll()
            }
        }
    }
    
    func reloadGame() {
        CardController.shared.cards.removeAll()
        randomizeCardImages()
        arrayToCompare.removeAll()
        
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
    
    func randomizeCardImages() {
        
        setImageAndLevel()

        while arrayToBeUsed.count != 0 {
            guard let mediumAllButtons = allButtons else { return }
            for button in mediumAllButtons {
                randomCardIndex = Int(arc4random_uniform(UInt32(arrayToBeUsed.count)))
                CardController.shared.createNewCardWith(cardImageName: arrayToBeUsed[randomCardIndex], cardTag: button.tag)
                print(self.arrayToBeUsed[self.randomCardIndex])
                button.setImage(UIImage(named: self.arrayToBeUsed[self.randomCardIndex]), for: .normal)
                guard let buttonImage = button.imageView else { return }
                buttonImage.layer.cornerRadius = 20
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.setbackOfImages()
                }
                arrayToBeUsed.remove(at: self.randomCardIndex)
            }
        }
    }
}
