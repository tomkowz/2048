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
        let pointsString = "\(points)"
        let text = "HIGH SCORE: \(points)"
        let attributed = NSMutableAttributedString(string: text)
        attributed.setAttributes([NSForegroundColorAttributeName: AppColor.Yellow.color], range: NSMakeRange(count(text) - count(pointsString), count(pointsString)))
        return attributed
    }
}