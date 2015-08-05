//
//  GameViewController.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameBoardViewDelegate, GameLogicManagerDelegate, GameOverViewControllerDelegate {

    enum SegueIdentifier: String {
        case GameOver = "GameOver"
    }
    
    @IBOutlet private var currentScoreLabel: UILabel!
    @IBOutlet private var bestScoreLabel: UILabel!
    @IBOutlet private var restartButton: UIButton!
    @IBOutlet private var finishButton: UIButton!
    @IBOutlet private var boardView: GameBoardView!
    
    private let gameManager = GameLogicManager()
    private let viewModel = GameViewModel()
    private var renderer: GameBoardRenderer!

    private var currentScore: Int = 0
    private var win: Bool = false
    var highScore: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardView.delegate = self
        renderer = GameBoardRenderer(boardView: boardView)
        
        gameManager.delegate = self
        gameManager.startGame()
        
        restartButton.styleLight()
        finishButton.styleLight()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateScores()
    }
    
    private func gameOver() {
        saveHighScore()
        self.performSegueWithIdentifier(SegueIdentifier.GameOver.rawValue, sender: nil)
    }
    
    private func userWin() {
        win = true
        saveHighScore()
        self.performSegueWithIdentifier(SegueIdentifier.GameOver.rawValue, sender: nil)
    }
    
    private func saveHighScore() {
        if NSUserDefaults.standardUserDefaults().highScore() < currentScore {
            NSUserDefaults.standardUserDefaults().saveHighScore(currentScore)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifier.GameOver.rawValue {
            let gameOverViewController = segue.destinationViewController as! GameOverViewController
            gameOverViewController.score = currentScore
            gameOverViewController.delegate = self
            gameOverViewController.win = win
        }
    }
    
    private func updateScores() {
        currentScoreLabel.attributedText = viewModel.scoreText(currentScore)
        bestScoreLabel.attributedText = viewModel.bestScoreText(highScore)
    }
    
    private func restart() {
        renderer.reset()
        currentScore = 0
        highScore = NSUserDefaults.standardUserDefaults().highScore()
        updateScores()
        gameManager.startGame()
    }
    
    @IBAction func restartPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Restart Game", message: "Are you sure?", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { _ in self.restart() }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func finishPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Finish Game", message: "Are you sure?", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { _ in self.gameOver() }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: GameBoardViewDelegate
    func gameBoardView(view: GameBoardView, didSwipeInDirection direction: ShiftDirection) {
        gameManager.shift(direction)
    }
    
    // MARK: GameLogicManagerDelegate
    func gameLogicManagerDidAddTile(tile: Tile?) {
        if let tile = tile { renderer.addTile(tile) }
    }
    
    func gameLogicManagerDidMoveTile(sourceTile: Tile, onTile destinationTile: Tile, completionBlock: (Void) -> Void) {
        renderer.moveTile(sourceTile, onTile: destinationTile, completionBlock: completionBlock)
    }
    
    func gameLogicManagerDidMoveTile(tile: Tile, position: Position, completionBlock: (Void) -> Void) {
        renderer.moveTile(tile, position: position, completionBlock: completionBlock)
    }
    
    func gameLogicManagerDidCountPoints(points: Int) {
        currentScore = points
        if highScore < points { highScore = points }
        updateScores()
    }
    
    func gameLogicManagerDidGameOver() {
        gameOver()
    }
    
    func gameLogicManagerDidWinGame() {
        userWin()
    }
    
    // MARK: GameOverViewControllerDelegate
    func gameOverControllerDidTapRestart() {
        restart()
    }
}
