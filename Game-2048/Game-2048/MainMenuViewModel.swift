//
//  MainMenuViewModel.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class MainMenuViewModel {
    private let points: Int
    
    init(points: Int) {
        self.points = points
    }
    
    var highScoreText: NSAttributedString {
        return NSMutableAttributedString.scoreDescription("HIGH SCORE", points: points)
    }
}