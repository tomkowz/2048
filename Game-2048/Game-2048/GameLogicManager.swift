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
    
    private let boardWidth = 4
    private let boardHeight = 4
    
    var delegate: GameLogicManagerDelegate?
    var tiles = [Tile]()
    
    func prepare() {
        for row in 0..<boardWidth {
            for column in 0..<boardHeight {
                tiles.append(Tile(position: CGPoint(x: row, y: column)))
            }
        }
        
        let boardRect = CGRectMake(CGFloat(0.0), CGFloat(0.0), CGFloat(boardWidth - 1), CGFloat(boardHeight - 1))
        for tile in tiles {
            let up = CGPointMake(tile.position.x, tile.position.y - 1)
            if CGRectContainsPoint(boardRect, up) {
                tile.upTile = tileForPosition(up)
            }
            
            let right = CGPointMake(tile.position.x + 1, tile.position.y)
            if CGRectContainsPoint(boardRect, right) {
                tile.rightTile = tileForPosition(right)
            }
            
            let bottom = CGPointMake(tile.position.x, tile.position.y + 1)
            if CGRectContainsPoint(boardRect, bottom) {
                tile.bottomTile = tileForPosition(bottom)
            }
            
            let left = CGPointMake(tile.position.x - 1, tile.position.y)
            if CGRectContainsPoint(boardRect, left) {
                tile.leftTile = tileForPosition(left)
            }
        }
    }
    
    func startGame() {
        addRandomTile()
        addRandomTile()
        delegate?.gameLogicManager(self, didUpdateTiles: tiles)
    }
    
    func shiftTiles(direction: UISwipeGestureRecognizerDirection) {
        addRandomTile()
        delegate?.gameLogicManager(self, didUpdateTiles: tiles)
    }
    
    private func addRandomTile() {
        if let position = generatePosition() {
            let Tile = tileForPosition(position)
            Tile.value = 2
            print(Tile.position)
        }
    }
    
    private func tileForPosition(position: CGPoint) -> Tile {
        return tiles.filter({$0.position == position}).first!
    }
    
    private var freeTiles: Int {
        return tiles.filter({$0.value == nil}).count
    }
    
    private func generatePosition() -> CGPoint? {
        if freeTiles == 0 { return nil }

        func isEmpty(point: CGPoint) -> Bool {
            return tileForPosition(point).value == nil
        }
        
        var position: CGPoint?
        while (position == nil) {
            let x = Int(arc4random_uniform(UInt32(boardWidth)))
            let y = Int(arc4random_uniform(UInt32(boardHeight)))
            var p = CGPoint(x: x, y: y)
            if isEmpty(p) == true {
                position = p
                break
            }
        }
        
        return position
    }
}