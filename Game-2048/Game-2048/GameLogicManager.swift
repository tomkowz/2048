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
    func gameLogicManagerDidAddTile(tile: Tile?)
    func gameLogicManagerDidMoveTile(sourceTile: Tile, onTile destinationTile: Tile)
    func gameLogicManagerDidMoveTile(tile: Tile, position: CGPoint)
}

class GameLogicManager {
    
    private let boardColumns = 4
    private let boardRows = 4
    
    var delegate: GameLogicManagerDelegate?
    var tiles = [Tile]()
    
    func prepare() {
        for row in 0..<boardColumns {
            for column in 0..<boardRows {
                tiles.append(Tile(position: CGPoint(x: row, y: column)))
            }
        }
        
        refreshNeighborTiles()
    }
    
    func startGame() {
        delegate?.gameLogicManagerDidAddTile(addRandomTile())
        delegate?.gameLogicManagerDidAddTile(addRandomTile())
    }
    
    func shiftTiles(direction: UISwipeGestureRecognizerDirection) {
        var shifted = false
        switch direction {
        case UISwipeGestureRecognizerDirection.Up:
            println("top")
        case UISwipeGestureRecognizerDirection.Right:
            shifted = shiftRight()
        case UISwipeGestureRecognizerDirection.Down:
            println("bottom")
        case UISwipeGestureRecognizerDirection.Left:
            println("left")
        default:
            break
        }
        
        // Every shift method returns boolean value if shift has been performed on 
        // some at least one tile or not.
        if shifted {
            delegate?.gameLogicManagerDidAddTile(addRandomTile())
        }
    }
    
    func shiftRight() -> Bool {
        var shifted = false
        for row in 0..<boardRows {
            let tilesInRow = reverse(tiles.filter({Int($0.position.y) == row}))
            for currentTile in tilesInRow {
                
                // Find first tile with some value
                if let otherTile = tilesInRow.filter({$0.position.x < currentTile.position.x && $0.value != nil}).first {
                    // If value is same increase value of current tile and 
                    // remove value from other tile.
                    if otherTile.value == currentTile.value {
                        currentTile.value! *= 2
                        otherTile.value = nil
                        delegate?.gameLogicManagerDidMoveTile(otherTile, onTile: currentTile)
                        shifted = true
                    } else if currentTile.value == nil {
                        currentTile.value = otherTile.value
                        otherTile.value = nil
                        delegate?.gameLogicManagerDidMoveTile(otherTile, position: currentTile.position)
                        shifted = true
                    }
                }
            }
        }
        return shifted
    }
    
    private func addRandomTile() -> Tile? {
        if let position = generatePosition() {
            let tile = tileForPosition(position)
            tile.value = 2
            return tile
        }
        
        return nil
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
            let x = Int(arc4random_uniform(UInt32(boardColumns)))
            let y = Int(arc4random_uniform(UInt32(boardRows)))
            var p = CGPoint(x: x, y: y)
            if isEmpty(p) == true {
                position = p
                break
            }
        }
        
        return position
    }
    
    private func refreshNeighborTiles() {
        let boardRect = CGRectMake(CGFloat(0.0), CGFloat(0.0), CGFloat(boardColumns), CGFloat(boardRows))
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
}