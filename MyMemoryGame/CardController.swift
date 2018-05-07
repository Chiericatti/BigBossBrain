//
//  CardController.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import Foundation

class CardController {
    
    static var shared = CardController()
    
    var cards: [Card] = []
    
    func createNewCardWith(cardImageName: String, cardTag: Int) {
        let card = Card(cardImageName: cardImageName, cardTag: cardTag)
        cards.append(card)
    }
}
