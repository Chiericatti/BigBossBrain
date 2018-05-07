//
//  Card.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/4/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import Foundation

class Card {
    
    var isFaceUp: Bool = false
    let cardImageName: String
    let cardTag: Int
    
    init(cardImageName: String, cardTag: Int) {
        self.cardImageName = cardImageName
        self.cardTag = cardTag
    }
    
    
}
