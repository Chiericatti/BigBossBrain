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
    
    var levelMode = 0
    var arrayToBeUsed = [String]()
    var easyArray = ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle"]
    var mediumArray = ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat"]
    var hardArray = ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_rattata","_bellsprout","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_rattata","_bellsprout"]
    var veryHardArray =  ["_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_weedle","_venonat","_rattata","_bellsprout","_bulbasaur","_charmander","_pikachu","_psyduck","_snorlax","_squirtle","_jigglypuff","_zubat","_weedle","_venonat","_rattata","_bellsprout"]
    
    var allButtons: [UIButton]?
    
    var randomCardIndex = 0
    
    var arrayToCompare = [String]()
    
    func setbackOfImages() {
        guard let arrayOfButtons =  allButtons else { return }
        for button in arrayOfButtons {
            button.setImage(#imageLiteral(resourceName: "blue-clouds-day-fluffy-53594"), for: .normal)
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
    
    func randomizeCardImages() {
        
        if GameController.shared.levelMode == 1 {
            arrayToBeUsed = easyArray
        } else if GameController.shared.levelMode == 2 {
            arrayToBeUsed = mediumArray
        } else if GameController.shared.levelMode == 3 {
            arrayToBeUsed = hardArray
        } else if GameController.shared.levelMode == 4 {
            arrayToBeUsed = veryHardArray
        }
        
        while arrayToBeUsed.count != 0 {
            guard let mediumAllButtons = allButtons else { return }
            for button in mediumAllButtons {
                randomCardIndex = Int(arc4random_uniform(UInt32(arrayToBeUsed.count)))
                CardController.shared.createNewCardWith(cardImageName: arrayToBeUsed[randomCardIndex], cardTag: button.tag)
                print(self.arrayToBeUsed[self.randomCardIndex])
                button.setImage(UIImage(named: self.arrayToBeUsed[self.randomCardIndex]), for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.setbackOfImages()
                }
                arrayToBeUsed.remove(at: self.randomCardIndex)
            }
        }
    }
}
