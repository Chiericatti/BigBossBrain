//
//  Score.swift
//  MyMemoryGame
//
//  Created by Pedro Henrique Chiericatti on 5/9/18.
//  Copyright © 2018 Pedro Henrique Chiericatti. All rights reserved.
//

import Foundation

class Score: Codable {
    
    var points: Int
    var trophies: Int
    var classic: Int
    var professional: Int
    
    init(points: Int, trophies: Int, classic: Int, professional: Int) {
        self.points = points
        self.trophies = trophies
        self.classic = classic
        self.professional = professional
    }
}

class Trophy: Codable {
    
    var classicEasy: Int
    var classicMedium: Int
    var classicHard: Int
    var classicVeryHard: Int
    
    var proEasy: Int
    var proMedium: Int
    var proHard: Int
    var proVeryHard: Int
    
    init(classicEasy: Int, classicMedium: Int, classicHard: Int, classicVeryHard: Int, proEasy: Int, proMedium: Int, proHard: Int, proVeryHard: Int) {
        
        self.classicEasy = classicEasy
        self.classicMedium = classicMedium
        self.classicHard = classicHard
        self.classicVeryHard = classicVeryHard
        self.proEasy = proEasy
        self.proMedium = proMedium
        self.proHard = proHard
        self.proVeryHard = proVeryHard
        
    }
}
