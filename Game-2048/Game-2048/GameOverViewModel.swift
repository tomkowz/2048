//
//  GameOverViewModel.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class GameOverViewModel {
    let points: Int
    
    init(points: Int) {
        self.points = points
    }
    
    var scoreText: NSAttributedString {
        return NSMutableAttributedString.scoreDescription("SCORE", points: points)
    }
}