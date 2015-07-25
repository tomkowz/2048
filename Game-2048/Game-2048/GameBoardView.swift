//
//  GameBoardView.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

protocol GameBoardViewDelegate {
    func gameBoardView(view: GameBoardView, didSwipeInDirection direction: UISwipeGestureRecognizerDirection)
}

class GameBoardView: UIView {
    
    var delegate: GameBoardViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupGestures()
    }
    
    private func setupGestures() {
        let selector = Selector("handleSwipe:")
        let directions = [
            UISwipeGestureRecognizerDirection.Left,
            UISwipeGestureRecognizerDirection.Right,
            UISwipeGestureRecognizerDirection.Down,
            UISwipeGestureRecognizerDirection.Up]
        
        for direction in directions {
            let recognizer = UISwipeGestureRecognizer(target: self, action: selector)
            recognizer.direction = direction
            addGestureRecognizer(recognizer)
        }
    }
    
    func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        delegate?.gameBoardView(self, didSwipeInDirection: recognizer.direction)
    }
}
