//
//  GameOverViewController.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

protocol GameOverViewControllerDelegate {
    func gameOverControllerDidTapRestart()
}

class GameOverViewController: UIViewController {
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var restartButton: UIButton!
    @IBOutlet private var finishButton: UIButton!
    
    
    var delegate: GameOverViewControllerDelegate?
    var score: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.styleLight()
        finishButton.styleLight()
        scoreLabel.attributedText = GameOverViewModel(points: score).scoreText
    }
    
    @IBAction func restartPressed(sender: AnyObject) {
        delegate?.gameOverControllerDidTapRestart()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func finishPressed(sender: AnyObject) {
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
