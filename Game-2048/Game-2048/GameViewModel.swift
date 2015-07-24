//
//  GameViewModel.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class GameViewModel {
    
    func bestScoreText(points: Int) -> NSAttributedString {
        return NSMutableAttributedString.scoreDescription("BEST", points: points)
    }
    
    func scoreText(points: Int) -> NSAttributedString {
        return NSMutableAttributedString.scoreDescription("SCORE", points: points)
    }
}