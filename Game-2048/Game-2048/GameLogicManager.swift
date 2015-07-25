//
//  GameLogicManager.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public func ==(lhs: CGPoint, rhs: CGPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

protocol GameLogicManagerDelegate {
    func gameLogicManager(manager: GameLogicManager, didUpdateTiles tiles: [Tile])
}

class GameLogicManager {
    
    var delegate: GameLogicManagerDelegate?
    var tileNodes = [Tile]()
    
    func prepare() {
        for row in 0..<4 {
            for column in 0..<4 {
                tileNodes.append(Tile(position: CGPoint(x: row, y: column)))
            }
        }
    }
    
    func startGame() {
        addRandomTile()
        addRandomTile()
        delegate?.gameLogicManager(self, didUpdateTiles: tileNodes)
    }
    
    func shiftTiles(direction: UISwipeGestureRecognizerDirection) {
        addRandomTile()
        delegate?.gameLogicManager(self, didUpdateTiles: tileNodes)
    }
    
    private func addRandomTile() {
        if let position = generatePosition() {
            let Tile = tileForPosition(position)
            Tile.value = 2
            print(Tile.position)
        }
    }
    
    private func tileForPosition(position: CGPoint) -> Tile {
        return tileNodes.filter({$0.position == position}).first!
    }
    
    private var freeTiles: Int {
        return tileNodes.filter({$0.value == nil}).count
    }
    
    private func generatePosition() -> CGPoint? {
        if freeTiles == 0 { return nil }

        func isEmpty(point: CGPoint) -> Bool {
            return tileForPosition(point).value == nil
        }
        
        var position: CGPoint?
        while (position == nil) {
            let x = Int(arc4random_uniform(4))
            let y = Int(arc4random_uniform(4))
            var p = CGPoint(x: x, y: y)
            if isEmpty(p) == true {
                position = p
                break
            }
        }
        
        return position
    }
}