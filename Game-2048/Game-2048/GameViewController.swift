//
//  GameViewController.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameBoardViewDelegate, GameLogicManagerDelegate {

    @IBOutlet private var currentScoreLabel: UILabel!
    @IBOutlet private var bestScoreLabel: UILabel!
    @IBOutlet private var restartButton: UIButton!
    @IBOutlet private var finishButton: UIButton!
    @IBOutlet private var boardView: GameBoardView!
    
    var currentScore: Int = 0
    var highScore: Int!
    
    private let gameManager = GameLogicManager()
    private let viewModel = GameViewModel()
    private var renderer: GameBoardRenderer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardView.delegate = self
        renderer = GameBoardRenderer(boardView: boardView)
        
        gameManager.delegate = self
        gameManager.prepare()
        gameManager.startGame()
        
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
    }
    
    @IBAction func restartPressed(sender: AnyObject) {
    }
    
    @IBAction func finishPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: GameBoardViewDelegate
    func gameBoardView(view: GameBoardView, didSwipeInDirection direction: UISwipeGestureRecognizerDirection) {
        gameManager.shiftTiles(direction)
    }
    
    
    // MARK: GameLogicManagerDelegate
    func gameLogicManagerDidAddTile(tile: Tile?) {
        if let tile = tile {
            renderer.addTile(tile)
        } else {
            println("game over!")
        }
    }
    
    func gameLogicManagerDidMoveTile(sourceTile: Tile, onTile destinationTile: Tile) {
        renderer.moveTile(sourceTile, onTile: destinationTile)
    }
    
    func gameLogicManagerDidMoveTile(tile: Tile, position: CGPoint) {
        renderer.moveTile(tile, position: position)
    }
}
