//
//  GameViewController.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    let gameManager = GameLogicManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameManager.prepare()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        for idx in 0..<16 {
            gameManager.addRandomTile()
        }
    }
}
