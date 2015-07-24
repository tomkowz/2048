//
//  GameViewController.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet private var currentScoreLabel: UILabel!
    @IBOutlet private var bestScoreLabel: UILabel!
    @IBOutlet private var restartButton: UIButton!
    @IBOutlet private var finishButton: UIButton!
    
    var currentScore: Int = 0
    var highScore: Int!
    
    private let gameManager = GameLogicManager()
    private let viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameManager.prepare()
        
        restartButton.styleLight()
        finishButton.styleLight()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        currentScoreLabel.attributedText = viewModel.scoreText(currentScore)
        bestScoreLabel.attributedText = viewModel.bestScoreText(highScore)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        for idx in 0..<16 {
            gameManager.addRandomTile()
        }
    }
    
    @IBAction func restartPressed(sender: AnyObject) {
    }
    
    @IBAction func finishPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
