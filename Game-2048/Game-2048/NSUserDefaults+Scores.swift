//
//  NSUserDefaults+Scores.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

extension NSUserDefaults {
    
    enum Key: String {
        case HighScore = "HighScore"
    }
    
    func registerDefaults() {
        NSUserDefaults.standardUserDefaults().registerDefaults([Key.HighScore.rawValue: NSNumber(integer: 0)])
    }
    
    func highScore() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey(Key.HighScore.rawValue)
    }
    
    func saveHighScore(score: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(score, forKey: Key.HighScore.rawValue)
        defaults.synchronize()
    }
}