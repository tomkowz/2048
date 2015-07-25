//
//  GameLogicManager.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation
import UIKit

protocol GameLogicManagerDelegate {
    func gameLogicManagerDidAddTile(tile: Tile?)
    func gameLogicManagerDidMoveTile(sourceTile: Tile, onTile destinationTile: Tile)
    func gameLogicManagerDidMoveTile(tile: Tile, position: Position)
    func gameLogicManagerDidCountPoints(points: Int)
}

enum ShiftDirection {
    case Up, Right, Down, Left
}

class GameLogicManager {
    
    private let boardColumns = 4
    private let boardRows = 4
    
    var delegate: GameLogicManagerDelegate?
    private var tiles = [Tile]()
    private var points = 0
    private var updating: Bool = false
    
    func prepare() {
        for row in 0..<boardColumns {
            for column in 0..<boardRows {
                tiles.append(Tile(position: Position(x: row, y: column)))
            }
        }
        refreshNeighborTiles()
    }
    
    func startGame() {
        points = 0
        delegate?.gameLogicManagerDidAddTile(addRandomTile())
        delegate?.gameLogicManagerDidAddTile(addRandomTile())
    }
    
    func shift(direction: ShiftDirection) {
        if updating == true { return }
        updating = true
        
        var shifted = false
        
        let elements = (direction == .Right || direction == .Left) ? boardRows : boardColumns
        for rowOrColumn in 0..<elements {
            // Get all tiles in a row or column.
            var tilesToCheck = tiles.filter({
                let value = (direction == .Left || direction == .Right) ? $0.position.y : $0.position.x
                return value == rowOrColumn
            })
            
            // When shifting right or down array need to be reversed.
            if direction == .Right || direction == .Down {
                tilesToCheck = reverse(tilesToCheck)
            }
            
            var tileIndex = 0
            while tileIndex < tilesToCheck.count {
                let currentTile = tilesToCheck[tileIndex]
                // Find first tile with some value
                // When shifting right filter seeks for tiles on the left,
                // otherwise on the right from current tile.
                let filter: ((tile: Tile) -> Bool) = { tile in
                    var position: Bool
                    switch direction {
                    case .Up: position = tile.position.y > currentTile.position.y
                    case .Right: position = tile.position.x < currentTile.position.x
                    case .Down: position = tile.position.y < currentTile.position.y
                    case .Left: position = tile.position.x > currentTile.position.x
                    }
                    
                    return position == true && tile.value != nil
                }
                
                if let otherTile = tilesToCheck.filter(filter).first {
                    // If value is same increase value of current tile and
                    // remove value from other tile.
                    if otherTile.value == currentTile.value {
                        moveOnSameTile(otherTile, onTile: currentTile)
                        // Notify about additional points because of adding up values
                        points += currentTile.value!
                        delegate?.gameLogicManagerDidCountPoints(points)
                        shifted = true
                    } else if currentTile.value == nil {
                        moveOnEmptyTile(otherTile, destinationTile: currentTile)
                        // if tile has been moved to another place repeat this step
                        // because maybe next tile has the same value and they
                        // should be added up.
                        tileIndex--
                        shifted = true
                    }
                }
                tileIndex++
            }
            
        }

        // Every shift method returns boolean value if shift has been performed on
        // some at least one tile or not.
        if shifted {
            delegate?.gameLogicManagerDidAddTile(addRandomTile(onEdge:true))
        }
        updating = false
    }
    
    private func moveOnSameTile(sourceTile: Tile, onTile destinationTile: Tile) {
        destinationTile.value! *= 2
        sourceTile.value = nil
        delegate?.gameLogicManagerDidMoveTile(sourceTile, onTile: destinationTile)
    }
    
    private func moveOnEmptyTile(sourceTile: Tile, destinationTile: Tile) {
        destinationTile.value = sourceTile.value
        sourceTile.value = nil
        delegate?.gameLogicManagerDidMoveTile(sourceTile, position: destinationTile.position)
    }
    
    private func addRandomTile(onEdge: Bool = false) -> Tile? {
        // If found position then create tile
        if let position = randomPosition(onEdge: onEdge) {
            let tile = tileForPosition(position)
            tile.value = 2
            return tile
        }
        return nil
    }
    
    private func tileForPosition(position: Position) -> Tile {
        return tiles.filter({$0.position == position}).first!
    }
    
    private func randomPosition(onEdge: Bool = false) -> Position? {
        var emptyTiles = tiles.filter({$0.value == nil})
        if onEdge == false && emptyTiles.count > 0 {
            return emptyTiles[Int(arc4random_uniform(UInt32(emptyTiles.count)))].position
        } else if onEdge == true {
            // Get empty edge position
            let emptyEdgeTiles = emptyTiles.filter({$0.position.x == 0 || $0.position.y == 0})
            if emptyEdgeTiles.count > 0 {
                return emptyEdgeTiles[Int(arc4random_uniform(UInt32(emptyEdgeTiles.count)))].position
            }
        }
        return nil
    }
    
    private func refreshNeighborTiles() {
        let boardRect = CGRectMake(CGFloat(0.0), CGFloat(0.0), CGFloat(boardColumns), CGFloat(boardRows))
        for tile in tiles {
            let up = Position(x: tile.position.x, y: tile.position.y - 1)
            if CGRectContainsPoint(boardRect, up.CGPointRepresentation) {
                tile.upTile = tileForPosition(up)
            }
            
            let right = Position(x: tile.position.x + 1, y: tile.position.y)
            if CGRectContainsPoint(boardRect, right.CGPointRepresentation) {
                tile.rightTile = tileForPosition(right)
            }
            
            let bottom = Position(x: tile.position.x, y: tile.position.y + 1)
            if CGRectContainsPoint(boardRect, bottom.CGPointRepresentation) {
                tile.bottomTile = tileForPosition(bottom)
            }
            
            let left = Position(x: tile.position.x - 1, y: tile.position.y)
            if CGRectContainsPoint(boardRect, left.CGPointRepresentation) {
                tile.leftTile = tileForPosition(left)
            }
        }
    }
}