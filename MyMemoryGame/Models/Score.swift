//
//  Score.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/9/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import Foundation

class Score: Codable {
    
    var score: Int
    
    init(score: Int) {
        self.score = score
    }
}
