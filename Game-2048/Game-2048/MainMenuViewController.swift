//
//  MainMenuViewController.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    enum SegueIdentifier: String {
        case NewGame = "NewGame"
    }
    
    @IBOutlet private var highScoreLabel: UILabel!
    @IBOutlet private var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.styleLight()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let highScore = NSUserDefaults.standardUserDefaults().highScore()
        let viewModel = MainMenuViewModel(points: highScore)
        highScoreLabel.attributedText = viewModel.highScoreText
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier = segue.identifier {
            switch SegueIdentifier(rawValue: segueIdentifier)! {
            case .NewGame:
                let gameViewController = segue.destinationViewController as! GameViewController
                gameViewController.highScore = NSUserDefaults.standardUserDefaults().highScore()
            }
        }
    }
}

